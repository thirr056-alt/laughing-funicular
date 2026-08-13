FROM kalilinux/kali-rolling

ENV DEBIAN_FRONTEND=noninteractive

# تثبيت واجهة XFCE الخفيفة، خدمة XRDP للتحكم الرسومي، وأداة ttyd للطرفية عبر المتصفح
RUN apt-get update && apt-get install -y --no-install-recommends \
    xfce4 \
    xfce4-goodies \
    xrdp \
    ttyd \
    sudo \
    curl \
    wget \
    procps \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# تعيين كلمة المرور لحساب الروتس وإعدادات واجهة الجلسة
RUN echo "root:kalilinux" | chpasswd
RUN echo "startxfce4" > /root/.xsession

# فتح منفذ RDP القياسي
EXPOSE 3389

# تشغيل خدمة XRDP في الخلفية، وتشغيل الطرفية عبر المتصفح باستخدام بورت Railway الديناميكي
CMD service xrdp start && ttyd -p ${PORT:-8080} -c admin:password bash
