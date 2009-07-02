From: Tai-hwa Liang <avatar@sentelic.com>
Subject: Re: [resend] [linux 2.6] new mouse driver looking for review and
 integration (fwd)
Date: Thu, 2 Jul 2009 18:21:24 +0800 (CST)
Message-ID: <090702181752C.28033@cnaqrzbavhz.fragryvp.pbz>
References: <09062313343417.14309@cnaqrzbavhz.fragryvp.pbz>
 <20090623061047.GC14724@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www.sentelic.com ([203.69.18.19]:30189 "EHLO www.sentelic.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751082AbZGBKV1 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 2 Jul 2009 06:21:27 -0400
In-Reply-To: <20090623061047.GC14724@dtor-d630.eng.vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

On Mon, 22 Jun 2009, Dmitry Torokhov wrote:
> Hi Tai-hwa,
> 
> No updates still, I was/am moving my family... After we unload our truck
> tomorrow I should have a bit more time on my hands.
> 
> I am not sure why I changed -EIO to -ENODEV, will change back, however I
> think that sysfs attributes shoudl stay 644 - we normally do not allow
> ordinary users change behavior of hardware; administrator can of course
> supply udev/hotplug rule to adjust permissions as needed.

Hi, Dmitry,

   Following are a few updates based on the sentelic git branch.  I've
reverted the sysfs attributes changes:

- Returning EIO instead of ENODEV when fsp_page_reg_read() failed;
- Removing unused variables from fsp_hw_state;
- Fixing wrong offset supplied to strict_strtoul() such that 'val' can be
   parsed correctly;
- Accept base 16 formatted integers as the userland specification said.

Signed-off-by:	Tai-hwa Liang <avatar@sentelic.com>

diff --git a/drivers/input/mouse/sentelic.c b/drivers/input/mouse/sentelic.c
index 5999378..30547f7 100644
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
@@ -554,11 +554,11 @@ static ssize_t fsp_attr_set_setreg(struct psmouse *psmouse, void *data,
  	char *rest;
  	ssize_t retval;

-	reg = simple_strtoul(buf, &rest, 10);
+	reg = simple_strtoul(buf, &rest, 16);
  	if (rest == buf || *rest != ' ' || reg > 0xff)
  		return -EINVAL;

-	if (strict_strtoul(buf, 10, &val) || val > 0xff)
+	if (strict_strtoul(rest + 1, 16, &val) || val > 0xff)
  		return -EINVAL;

  	if (fsp_reg_write_enable(psmouse, 1))
@@ -594,7 +594,7 @@ static ssize_t fsp_attr_set_getreg(struct psmouse *psmouse, void *data,
  	unsigned long reg;
  	int val;

-	if (strict_strtoul(buf, 10, &reg) || reg > 0xff)
+	if (strict_strtoul(buf, 16, &reg) || reg > 0xff)
  		return -EINVAL;

  	if (fsp_reg_read(psmouse, reg, &val))
@@ -615,7 +615,7 @@ static ssize_t fsp_attr_show_pagereg(struct psmouse *psmouse,
  	int val = 0;

  	if (fsp_page_reg_read(psmouse, &val))
-		return -ENODEV;
+		return -EIO;

  	return sprintf(buf, "%02x\n", val);
  }
@@ -625,7 +625,7 @@ static ssize_t fsp_attr_set_pagereg(struct psmouse *psmouse, void *data,
  {
  	unsigned long val;

-	if (strict_strtoul(buf, 10, &val) || val > 0xff)
+	if (strict_strtoul(buf, 16, &val) || val > 0xff)
  		return -EINVAL;

  	if (fsp_page_reg_write(psmouse, val))
diff --git a/drivers/input/mouse/sentelic.h b/drivers/input/mouse/sentelic.h
index 03d7ab8..9c00c19 100644
--- a/drivers/input/mouse/sentelic.h
+++ b/drivers/input/mouse/sentelic.h
@@ -83,9 +83,6 @@ struct fsp_data {
  #define	FSPDRV_FLAG_AUTO_SWITCH	(0x400)	/* software on-pad icon auto switch */
  #define	FSPDRV_FLAG_EN_OPC	(0x800)	/* enable on-pad clicking */
  #define FSP_RESP_PKT_MAXLEN	(8)	/* The max response packet size. */
-	unsigned char		cmd;	/* The buffer used to store the sending PS/2 command */
-	unsigned char		resp[FSP_RESP_PKT_MAXLEN]; /* The buffer used to store the response of PS/2 command */
-	int			resp_cnt;	/* The command count in resp buffer */
  	unsigned char		buttons;	/* Number of buttons */
  	unsigned char		ver;		/* hardware version */
  	unsigned char		rev;		/* hardware revison */


> On Tue, Jun 23, 2009 at 01:35:10PM +0800, Tai-hwa Liang wrote:
> > Hi, Dmitry,
> >
> >   Any update on this one?
> >
> > ---------- Forwarded message ----------
> > Date: Thu, 21 May 2009 15:58:14 +0800 (CST)
> > From: Tai-hwa Liang <avatar@sentelic.com>
> > To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Cc: linux-input@vger.kernel.org
> > Subject: Re: [linux 2.6] new mouse driver looking for review and  integration
> >     (fwd)
> >
> > On Thu, 14 May 2009, Tai-hwa Liang wrote:
> >> On Wed, 13 May 2009, Dmitry Torokhov wrote:
> >>> On Wed, May 13, 2009 at 05:56:39PM +0800, Tai-hwa Liang wrote:
> >>> > On Fri, 8 May 2009, Dmitry Torokhov wrote:
> >>> >> Hi Tai-hwa,
> >>> >>
> >>> >> On Thursday 07 May 2009 22:30:52 Tai-hwa Liang wrote:
> >>> >> > Hi, Dmitry,
> >>> >> >
> >>> >> >    I'm wondering about the status of the patch you submitted to 
> >>> git. Will
> >>> >> > it being merged into 2.6.31?
> >>> >> >
> >>> >>
> >>> >> I really need to get back to it. The weekend is coming up, I 
> >>> should >> have time to go over it, I shall respond by Monday.
> >>> >
> >>> >   Thanks.  Where is the git repository I can use to retrieve the 
> >>> code you've
> >>> > submitted?  I have a few changes for your patched code.
> >>> >
> >>>
> >>> I have created "sentelic" branch here:
> >>>
> >>> 	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git
> >>>
> >>> I fetched the latest version of the driver off the sourceforge page and
> >>> used it as the baseline.
> >>
> >>  Thank you.  I'm reading through the differences.  Looks good to me so far.
> >>
> >>> The idea is to implement full absolute packet support and not rely on
> >>> relative packets because users will expect Synaptics X driver work with
> >>> this device as it works with all other touchpads (Synaptics, ALPS,
> >>> Elantec, BCM, appletouch).
> >>
> >>  I can understand that; however, absolute coordinates returned by
> >> current FSP hardware isn't suitable for cursor movement, which makes
> >> relative packet necessary if you want to have a functional hardware.
> >>
> >>> BTW, I have a few questions regarding protocol:
> >>>
> >>> What is 'arc', x1_g, x2_g, y1_g, y2_g in the absolute packet data?
> >>
> >>  Those are obsoleted information which used to represent finger tracks.
> >
> > Hi, Dmitry,
> >
> >   Following are a few changes based on the sentelic branch you've created:
> >
> > - Returning EIO instead of ENODEV when fsp_page_reg_read() failed;
> > - Reverting onpadicon and pktfmt sysfs node to world writable as userland
> >   application needs to write it without root privilege;
> > - Removing unused variables from fsp_hw_state.
> >
> > Signed-off-by:	Tai-hwa Liang <avatar@sentelic.com>
> >
> > diff --git a/drivers/input/mouse/sentelic.c b/drivers/input/mouse/sentelic.c
> > index 5999378..d98c4d6 100644
> > --- a/drivers/input/mouse/sentelic.c
> > +++ b/drivers/input/mouse/sentelic.c
> > @@ -30,7 +30,7 @@
> >  #include "psmouse.h"
> >  #include "sentelic.h"
> >
> > -/*
> > +/**
> >   * Timeout for FSP PS/2 command only (in milliseconds).
> >   */
> >  #define	FSP_CMD_TIMEOUT		200
> > @@ -615,7 +615,7 @@ static ssize_t fsp_attr_show_pagereg(struct psmouse 
> > *psmouse,
> >  	int val = 0;
> >
> >  	if (fsp_page_reg_read(psmouse, &val))
> > -		return -ENODEV;
> > +		return -EIO;
> >
> >  	return sprintf(buf, "%02x\n", val);
> >  }
> > @@ -712,7 +712,7 @@ static ssize_t fsp_attr_set_onpadicon(struct psmouse 
> > *psmouse, void *data,
> >  	return count;
> >  }
> >
> > -PSMOUSE_DEFINE_ATTR(onpadicon, S_IWUSR | S_IRUGO, NULL,
> > +PSMOUSE_DEFINE_ATTR(onpadicon, S_IWUSR | S_IRUGO | S_IWUGO, NULL,
> >  			fsp_attr_show_onpadicon, fsp_attr_set_onpadicon);
> >
> >  static ssize_t fsp_attr_show_pktfmt(struct psmouse *psmouse,
> > @@ -738,7 +738,7 @@ static ssize_t fsp_attr_set_pktfmt(struct psmouse 
> > *psmouse, void *data,
> >  	return count;
> >  }
> >
> > -PSMOUSE_DEFINE_ATTR(pktfmt, S_IWUSR | S_IRUGO, NULL,
> > +PSMOUSE_DEFINE_ATTR(pktfmt, S_IWUSR | S_IRUGO | S_IWUGO, NULL,
> >  			fsp_attr_show_pktfmt, fsp_attr_set_pktfmt);
> >
> >  static ssize_t fsp_attr_show_flags(struct psmouse *psmouse,
> > diff --git a/drivers/input/mouse/sentelic.h b/drivers/input/mouse/sentelic.h
> > index 03d7ab8..9c00c19 100644
> > --- a/drivers/input/mouse/sentelic.h
> > +++ b/drivers/input/mouse/sentelic.h
> > @@ -83,9 +83,6 @@ struct fsp_data {
> >  #define	FSPDRV_FLAG_AUTO_SWITCH	(0x400)	/* software on-pad icon auto 
> > switch */
> >  #define	FSPDRV_FLAG_EN_OPC	(0x800)	/* enable on-pad clicking */
> >  #define FSP_RESP_PKT_MAXLEN	(8)	/* The max response packet size. */
> > -	unsigned char		cmd;	/* The buffer used to store the sending PS/2 
> > command */
> > -	unsigned char		resp[FSP_RESP_PKT_MAXLEN]; /* The buffer used to store 
> > the response of PS/2 command */
> > -	int			resp_cnt;	/* The command count in resp buffer */
> >  	unsigned char		buttons;	/* Number of buttons */
> >  	unsigned char		ver;		/* hardware version */
> >  	unsigned char		rev;		/* hardware revison */
