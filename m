From: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Subject: Re: Unknown ALPS touchpad
Date: Tue, 21 Feb 2017 08:05:35 -0300
Message-ID: <20170221110533.GA6386@xfiles>
References: <20170219131634.GA7453@riseup.net>
 <20170219133521.GA22927@pali>
 <76481654aedb6b687b145441283f3268@riseup.net>
 <20170219230105.GB11968@xfiles.domain.name>
 <20170220155108.GC20408@pali>
 <KAWPR01MB1092940E872BB3C233FE8033C7510@KAWPR01MB1092.jpnprd01.prod.outlook.com>
 <20170221083439.GA9795@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:34686 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751266AbdBULFo (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 21 Feb 2017 06:05:44 -0500
Content-Disposition: inline
In-Reply-To: <20170221083439.GA9795@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Masaki Ota <masaki.ota@jp.alps.com>, John Preston <wcerfgba@riseup.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, Feb 21, 2017 at 09:34:39AM +0100, Pali Rohár wrote:
> On Tuesday 21 February 2017 03:10:06 Masaki Ota wrote:
> > Hi, Pali,
> > 
> > I know these devices, and they are supported in new kernel.
> > I'm not sure when they are supported from.
> > In alps.c has below code.
> > 
> > static int alps_identify(struct psmouse *psmouse, struct alps_data *priv)
> > {...
> > ...
> > 		if (e7[0] == 0x73 && e7[1] == 0x03 && e7[2] == 0x50 &&
> > 			   ec[0] == 0x73 && (ec[1] == 0x01 || ec[1] == 0x02)) {
> > 			protocol = &alps_v5_protocol_data;
> > 		} else if (ec[0] == 0x88 &&
> > 			   ((ec[1] & 0xf0) == 0xb0 || (ec[1] & 0xf0) == 0xc0)) {
> > 			protocol = &alps_v7_protocol_data;}
> > }
> 
> Ou, sorry I have missed this checks for ec[0] == 0x88.
> 
> Marcos, so conclusion is that all those ALPS devices are already
> supported by last mainline kernel. So you can close those bug reports.
> If you need with git blame you can identify commit in which was support
> added and then you can find in which kernel version was particular
> commit first time.

Thanks Pali and Masaki, I closed all mentioned commits, pointing the
right kernel version that supports such devices.

> 
> > 
> > E7=73 03 50, EC=73 02 02 <- alps_v5_protocol_data
> > E7=73 03 0a, EC=88 b3 22 <- alps_v7_protocol_data
> > E7=73 03 0a, EC=88 b3 18 <- alps_v7_protocol_data
> > 
> > Best Regards,
> > Masaki Ota
> > -----Original Message-----
> > From: Pali Rohár [mailto:pali.rohar@gmail.com] 
> > Sent: Tuesday, February 21, 2017 12:51 AM
> > To: Marcos Paulo de Souza <marcos.souza.org@gmail.com>; 太田 真喜 Masaki Ota <masaki.ota@jp.alps.com>
> > Cc: John Preston <wcerfgba@riseup.net>; Dmitry Torokhov <dmitry.torokhov@gmail.com>; linux-input@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: Unknown ALPS touchpad
> > 
> > Adding Masaki into discussion.
> > 
> > On Sunday 19 February 2017 20:01:07 Marcos Paulo de Souza wrote:
> > > There are other open bugs mentioning the same problem, with similar ALPS devices:
> > > https://bugzilla.kernel.org/show_bug.cgi?id=57841
> > 
> > Unknown ALPS touchpad: E7=73 03 50, EC=73 02 02
> > 
> > > https://bugzilla.kernel.org/show_bug.cgi?id=43931
> > 
> > Unknown ALPS touchpad: E7=73 00 14, EC=10 00 64
> > 
> > Should be supported since commit 95f75e91 which was introduced in Linux version v3.13-rc4.
> > 
> > > https://bugzilla.kernel.org/show_bug.cgi?id=80181
> > 
> > Unknown ALPS touchpad: E7=73 03 0a, EC=88 b3 22
> > 
> > > https://bugzilla.kernel.org/show_bug.cgi?id=67941
> > 
> > Unknown ALPS touchpad: E7=73 03 0a, EC=88 b3 18
> > 
> > > This one without even a dmesg output:
> > > https://bugzilla.kernel.org/show_bug.cgi?id=84081
> > 
> > Sorry, this one does not contain any useful information.
> > 
> > > Maybe they are related, or  also need some touch to let them being discovered as proper devices?
> > 
> > Masaki, can you look at those unknown ALPS touchpad identifiers and provide some information about protocol which they are using?
> > 
> > Basically touchpads with these identifiers are unsupported by last kernel version:
> > 
> > E7=73 03 50, EC=73 02 02
> > E7=73 03 0a, EC=88 b3 22
> > E7=73 03 0a, EC=88 b3 18
> > 
> > --
> > Pali Rohár
> > pali.rohar@gmail.com
> 
> -- 
> Pali Rohár
> pali.rohar@gmail.com
