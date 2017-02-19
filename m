From: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Subject: Re: [PATCH] Add model data for Dell Precision 3510 trackpad.
Date: Sun, 19 Feb 2017 20:01:07 -0300
Message-ID: <20170219230105.GB11968@xfiles.domain.name>
References: <20170219131634.GA7453@riseup.net>
 <20170219133521.GA22927@pali>
 <76481654aedb6b687b145441283f3268@riseup.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:32833 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751042AbdBSXBU (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 19 Feb 2017 18:01:20 -0500
Content-Disposition: inline
In-Reply-To: <76481654aedb6b687b145441283f3268@riseup.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: John Preston <wcerfgba@riseup.net>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi John and Pali,

On Sun, Feb 19, 2017 at 03:24:58PM +0000, John Preston wrote:
> On 2017-02-19 13:35, Pali Rohár wrote:
> > On Sunday 19 February 2017 13:16:34 John L. Preston wrote:
> > > ---
> > >  drivers/input/mouse/alps.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> > > index 328edc8c8786..c0a4edefe54d 100644
> > > --- a/drivers/input/mouse/alps.c
> > > +++ b/drivers/input/mouse/alps.c
> > > @@ -139,6 +139,7 @@ static const struct alps_model_info
> > > alps_model_data[] = {
> > >  	{ { 0x52, 0x01, 0x14 }, 0x00, { ALPS_PROTO_V2, 0xff, 0xff,
> > >  		ALPS_PASS | ALPS_DUALPOINT | ALPS_PS2_INTERLEAVED } },				/*
> > > Toshiba Tecra A11-11L */
> > >  	{ { 0x73, 0x02, 0x64 }, 0x8a, { ALPS_PROTO_V4, 0x8f, 0x8f, 0 } },
> > > +	{ { 0x73, 0x03, 0x28 }, 0x13, { ALPS_PROTO_V8, 0x18, 0x18, 0 }
> > > },			/* Dell Precision 3510 */
> > >  };
> > > 
> > >  static const struct alps_protocol_info alps_v3_protocol_data = {
> > 
> > Hi John! This is not a correct place do add new proto data. I already
> > proposed reducing this table to just for PROTO_V2, but Dmitry was not
> > happy about it.
> 
> Hi Pali. :)
> 
> > 
> > Anyway, look at function alps_identify() where is detection for ALPS_V8:
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/input/mouse/alps.c?h=v4.10-rc8#n2829
> > 
> > V8 is already detected when e7 is (0x73, 0x03, 0x28) and ec[1] is 0x01.
> > What are your ec data? Probably ec[1] is not 0x01 as otherwise it should
> > be already detected.
> 
> I have just found that code and am confused because that is not the same
> code I have running on my system. My ec[1] is 0x01 so you are correct, it
> should already be detected and my patch is unnecessary. Sorry for the
> inconvenience.
> 
> > 
> > Btw, from where you got your proto data in this patch?
> 
> I pulled it from dmesg:
> 
> [john@slate ~]$ dmesg|grep "Unknown ALPS touchpad"
> [    3.071891] psmouse serio1: alps: Unknown ALPS touchpad: E7=73 03 28,
> EC=73 01 13

There are other open bugs mentioning the same problem, with similar ALPS devices:
https://bugzilla.kernel.org/show_bug.cgi?id=57841
https://bugzilla.kernel.org/show_bug.cgi?id=43931
https://bugzilla.kernel.org/show_bug.cgi?id=80181
https://bugzilla.kernel.org/show_bug.cgi?id=67941

This one without even a dmesg output:
https://bugzilla.kernel.org/show_bug.cgi?id=84081

Maybe they are related, or  also need some touch to let them being discovered as proper devices?

Thanks,
Marcos

> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
