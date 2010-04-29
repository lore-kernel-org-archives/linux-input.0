From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: [PATCH] Reset ps/2 port  should psmouse_probe fail before
	retrying
Date: Thu, 29 Apr 2010 18:57:48 +0200
Message-ID: <1272560268.3987.12.camel@lovely>
References: <1271723857.6652.6.camel@lovely>
	 <20100422215517.GB28213@core.coreip.homeip.net>
	 <1271983668.16254.44.camel@lovely>
	 <201004230953.52447.dmitry.torokhov@gmail.com>
	 <4BD1EB1C.1070200@canonical.com>
	 <20100428170721.GA6608@core.coreip.homeip.net>
	 <4BD897D4.4060405@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:60443 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932714Ab0D3RIl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Apr 2010 13:08:41 -0400
Received: by fg-out-1718.google.com with SMTP id 19so4463127fgg.1
        for <linux-input@vger.kernel.org>; Fri, 30 Apr 2010 10:08:37 -0700 (PDT)
In-Reply-To: <4BD897D4.4060405@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Peter M. Petrakis" <peter.petrakis@canonical.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, rubini <rubini@cvml.unipv.it>, Christopher Heiny <cheiny@synaptics.com>

On Wed, 2010-04-28 at 16:17 -0400, Peter M. Petrakis wrote:
> Dmitry,
> 
> This Dell in question do not have an option to disable the
> touchpad. The BIOS options are unremarkable.
> 
> Peter
> 
> On 04/28/2010 01:07 PM, Dmitry Torokhov wrote:
> > On Fri, Apr 23, 2010 at 02:46:52PM -0400, Peter M. Petrakis wrote:
> >> Here are the dmesg boot logs with i8042.debug. 
> >>
> >> On 04/23/2010 12:53 PM, Dmitry Torokhov wrote:
> >>> On Thursday 22 April 2010 05:47:48 pm Christoph Fritz wrote:
> >>>> Am Donnerstag, den 22.04.2010, 14:55 -0700 schrieb Dmitry Torokhov:
> >>>>> On Thu, Apr 22, 2010 at 05:48:21PM -0400, Peter M. Petrakis wrote:
> >>>>>> Hi,
> >>>>>>
> >>>>>> This one is a winner. with regards to your follow up. I wouldn't
> >>>>>> want to reset something unless we have cause to. This code
> >>>>>> seems to be doing the right thing e.g. I see "unable to query
> >>>>>> synaptics hardware" followed by it's (re)discovery on return
> >>>>>> from S3.
> >>>>>>
> >>>>>> When it's fully supported by the Synaptics driver, the initial
> >>>>>> reconnect will succeed and we'll never get to this additional
> >>>>>> failsafe code which is essentially a catch all for the bleeding
> >>>>>> edge.
> >>>>>
> >>>>> I am confused here... what protocol does the kernel select upon fresh
> >>>>> boot?
> >>>>
> >>>> Peter's dmesg:
> >>>>
> >>>> [    7.428561] Unable to query Synaptics hardware.
> >>>>
> >>>>  It's plain PS/2 or IMPS/2 because this bleeding edge device fails
> >>>> somewehre in synaptics_query_hardware(). Most likely the test on
> >>>> priv->identity.
> >>>
> >>> Ah, I missed that. Peter, could you boot with i8042.debug so we could see 
> >>> where exactly Synaptics detection fails?
> >>>
> > 
> > Indeed, capability request returns "d0 00 73" whereas we expect 0x47 in
> > the middle byte.

The synaptics docu [1] about "information queries" is a bit imprecise in
my view. It's clear to get "Identify TouchPad" with "E8 00 E8 00 E8 00
E8 00 E9". But as I understand it, to get "Read Capabilities" we should
do "E8 02 E8 02 E8 02 E8 02 E9" instead of "E8 00 E8 00 E8 00 E8 02 E9".

Peter, does the touchpad works with synaptics driver when you apply this
patch below?

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 026df60..aa25fbd 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -103,8 +103,12 @@ void synaptics_reset(struct psmouse *psmouse)
  */
 static int synaptics_send_cmd(struct psmouse *psmouse, unsigned char c, unsigned char *param)
 {
-	if (psmouse_sliced_command(psmouse, c))
-		return -1;
+	int i;
+
+	for (i = 0; i < 4; i++) {
+		if (ps2_command(&psmouse->ps2dev, param, PSMOUSE_CMD_SETRES))
+			return -1;
+	}
 	if (ps2_command(&psmouse->ps2dev, param, PSMOUSE_CMD_GETINFO))
 		return -1;
 	return 0;
---

Thanks,
 chf

[1]: http://www.synaptics.com/sites/default/files/511-000275-01rA.pdf


