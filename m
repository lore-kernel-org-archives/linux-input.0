From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] Input: synaptics-rmi4 - make F03 a tristate symbol
Date: Fri, 13 Jan 2017 22:06:12 +0100
Message-ID: <3051252.9A92ba0o10@wuerfel>
References: <20170110121718.2992211-1-arnd@arndb.de> <20170113062203.GD22630@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170113062203.GD22630@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, Nick Dyer <nick@shmanahar.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thursday, January 12, 2017 10:22:03 PM CET Dmitry Torokhov wrote:
> As it was explained townthread we can't [currently] make functions
> modules, in the meantime I have d7ddad0acc4add42567f7879b116a0b9eea31860
> that should fix this issue (and I just sent pull request for it).

On today's linux-next (which includes d7ddad0acc4ad), I was still
getting this warning :

warning: (HID_RMI) selects RMI4_F03 which has unmet direct dependencies (!UML && INPUT && RMI4_CORE && (SERIO=y || RMI4_CORE=SERIO))

This is my fixup, though I'm not too happy with that version.
    
Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 1aeb80e52424..3927259a5d5d 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -785,7 +785,8 @@ config HID_SUNPLUS
 config HID_RMI
 	tristate "Synaptics RMI4 device support"
 	depends on HID
-	select RMI4_CORE
+	depends on SERIO && RMI4_CORE
+	depends on SERIO=y || RMI4_CORE=SERIO
 	select RMI4_F03
 	select RMI4_F11
 	select RMI4_F12
