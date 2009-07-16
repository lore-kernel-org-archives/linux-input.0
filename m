From: Tai-hwa Liang <avatar@sentelic.com>
Subject: Re: [resend] [linux 2.6] new mouse driver looking for review and  
 integration
Date: Thu, 16 Jul 2009 15:07:47 +0800 (CST)
Message-ID: <09071614573917.21296@cnaqrzbavhz.fragryvp.pbz>
References: <09062313343417.14309@cnaqrzbavhz.fragryvp.pbz>
 <20090623061047.GC14724@dtor-d630.eng.vmware.com> <090702181752C.28033@cnaqrzbavhz.fragryvp.pbz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www.sentelic.com ([203.69.18.19]:26719 "EHLO www.sentelic.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750905AbZGPHHx (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Jul 2009 03:07:53 -0400
In-Reply-To: <090702181752C.28033@cnaqrzbavhz.fragryvp.pbz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Thu, 2 Jul 2009, Tai-hwa Liang wrote:
> On Mon, 22 Jun 2009, Dmitry Torokhov wrote:
>> Hi Tai-hwa,
>> 
>> No updates still, I was/am moving my family... After we unload our truck
>> tomorrow I should have a bit more time on my hands.
[...]
>>

Hi, Dmitry,

   Thanks for applying my patch.  I saw you removed accel from driver --
this was done in kernel as users may have different acceleration
preferences on different input devices.  Is there any other APIs that
supports different acceleration parameters for different input devices?
XChangePointerControl(3) seems to change acceleration parameters globally
to me.

   In addition to that, here are are more changes against current sentelic 
branch:

- base 10 -> 16 conversion for two more places missed in previous
   submission(user land library feeds based 16 parameters to sysfs node);
- Warpping 'struct psmouse' related functions with __KERNEL__ such that
   user land application(libfsp) can build with this header file.

Signed-off-by:	Tai-hwa Liang <avatar@sentelic.com>

diff --git a/drivers/input/mouse/sentelic.c b/drivers/input/mouse/sentelic.c
index 557b14a..909ac2c 100644
--- a/drivers/input/mouse/sentelic.c
+++ b/drivers/input/mouse/sentelic.c
@@ -30,7 +30,7 @@
  #include "psmouse.h"
  #include "sentelic.h"

-/*
+/**
   * Timeout for FSP PS/2 command only (in milliseconds).
   */
  #define	FSP_CMD_TIMEOUT		200
@@ -594,7 +594,7 @@ static ssize_t fsp_attr_set_getreg(struct psmouse *psmouse, void *data,
  	unsigned long reg;
  	int val;

-	if (strict_strtoul(buf, 10, &reg) || reg > 0xff)
+	if (strict_strtoul(buf, 16, &reg) || reg > 0xff)
  		return -EINVAL;

  	if (fsp_reg_read(psmouse, reg, &val))
@@ -625,7 +625,7 @@ static ssize_t fsp_attr_set_pagereg(struct psmouse *psmouse, void *data,
  {
  	unsigned long val;

-	if (strict_strtoul(buf, 10, &val) || val > 0xff)
+	if (strict_strtoul(buf, 16, &val) || val > 0xff)
  		return -EINVAL;

  	if (fsp_page_reg_write(psmouse, val))
diff --git a/drivers/input/mouse/sentelic.h b/drivers/input/mouse/sentelic.h
index 1f6c4ab..fa2c0e0 100644
--- a/drivers/input/mouse/sentelic.h
+++ b/drivers/input/mouse/sentelic.h
@@ -104,6 +104,7 @@ struct fsp_data {
  	struct fsp_hw_state	hw_state;
  };

+#ifdef __KERNEL__
  #ifdef CONFIG_MOUSE_PS2_SENTELIC
  extern int fsp_detect(struct psmouse *psmouse, int set_properties);
  extern int fsp_init(struct psmouse *psmouse);
@@ -117,5 +118,6 @@ inline int fsp_init(struct psmouse *psmouse)
  	return -ENOSYS;
  }
  #endif
+#endif	/* __KERNEL__ */

-#endif	/* __SENTELIC_H */
+#endif	/* !__SENTELIC_H */

-- 
Thanks,

Tai-hwa Liang
