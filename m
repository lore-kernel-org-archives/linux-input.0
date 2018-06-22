From: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: elantech - Fix V4 report decoding for module with
 middle key
Date: Thu, 21 Jun 2018 17:16:32 -0700
Message-ID: <20180622001632.GI79890@dtor-ws>
References: <1527507182-3858-1-git-send-email-kt.liao@emc.com.tw>
 <20180529180506.GB167092@dtor-ws>
 <000301d3f7e4$5c9e51c0$15daf540$@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <000301d3f7e4$5c9e51c0$15daf540$@emc.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?5buW5bSH5qau?= <kt.liao@emc.com.tw>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, ulrik.debie-os@e2big.org, phoenix@emc.com.tw, aaron.ma@canonical.com, josh.chen@emc.com.tw
List-Id: linux-input@vger.kernel.org

On Wed, May 30, 2018 at 03:03:50PM +0800, 廖崇榮 wrote:
> Hi Dmitry,
> 
> -----Original Message-----
> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com] 
> Sent: Wednesday, May 30, 2018 2:05 AM
> To: KT Liao
> Cc: linux-kernel@vger.kernel.org; linux-input@vger.kernel.org;
> ulrik.debie-os@e2big.org; phoenix@emc.com.tw; aaron.ma@canonical.com;
> josh.chen@emc.com.tw
> Subject: Re: [PATCH] Input: elantech - Fix V4 report decoding for module
> with middle key
> 
> Hi KT,
> 
> On Mon, May 28, 2018 at 07:33:02PM +0800, KT Liao wrote:
> > Some touchpad has middle key and it will be indicated in bit 2 of
> packet[0].
> > We need to fix V4 formation's byte mask to prevent error decoding.
> 
> Could you please let me know what devices this patch fixes? Are they
> released or new hardware?
> 
> 
> The primary target is Lenovo thinkpad P52 and it will be released in 6/M.
> 
> force_crc_enabled will fix the issue too because less bit-check in the
> specific byte. 
> I guess Fujitsu H730/H760 in elantech_dmi_force_crc_enabled may have the
> same issue.
> I leave them in DMI table because I am not sure of it.

OK, thank you for the info. Applied.

> 
> Thanks
> KT
> > 
> > Signed-off-by: KT Liao <kt.liao@emc.com.tw>
> > ---
> >  drivers/input/mouse/elantech.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/input/mouse/elantech.c 
> > b/drivers/input/mouse/elantech.c index fb4d902..f39dc66 100644
> > --- a/drivers/input/mouse/elantech.c
> > +++ b/drivers/input/mouse/elantech.c
> > @@ -799,7 +799,7 @@ static int elantech_packet_check_v4(struct psmouse
> *psmouse)
> >  	else if (ic_version == 7 && etd->info.samples[1] == 0x2A)
> >  		sanity_check = ((packet[3] & 0x1c) == 0x10);
> >  	else
> > -		sanity_check = ((packet[0] & 0x0c) == 0x04 &&
> > +		sanity_check = ((packet[0] & 0x08) == 0x00 &&
> >  				(packet[3] & 0x1c) == 0x10);
> >  
> >  	if (!sanity_check)
> > --
> > 2.7.4
> > 
> 
> Thanks.
> 
> -- 
> Dmitry
> 

-- 
Dmitry
