From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: pwm-beeper: support customized freq for SND_BELL
Date: Mon, 13 Feb 2017 20:27:48 -0800
Message-ID: <20170214042748.GC19688@dtor-ws>
References: <1486444894-18321-1-git-send-email-hs@denx.de>
 <20170207181309.GC38092@dtor-ws>
 <850c2508720a41b3bfb95cd7093433a4@SI-MBX1030.de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <850c2508720a41b3bfb95cd7093433a4@SI-MBX1030.de.bosch.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Jonas Mark (ST-FIR/ENG1)" <Mark.Jonas@de.bosch.com>
Cc: Heiko Schocher <hs@denx.de>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "GUAN Ben (ST-FIR/ENG1-Zhu)" <Ben.Guan@cn.bosch.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Rob Herring <robh+dt@kernel.org>, Manfred Schlaegl <manfred.schlaegl@gmx.at>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-input@vger.kernel.org

On Wed, Feb 08, 2017 at 10:11:21AM +0000, Jonas Mark (ST-FIR/ENG1) wrote:
> Hello Dmitry,
> 
> > > extend the pwm-beeper driver to support customized frequency
> > > for SND_BELL from device tree.
> > 
> > No, SND_BELL is literally SND_TONE @1000Hz. There should be no
> > customizing. If applications want to use different frequency then should
> > be using SND_TONE.
> 
> We are not aiming for an application shortcut here. Instead, changing
> the bell frequency shall be a system setting. That is, every
> application which wants to make a bell sound shall use the alternative
> frequency.
> 
> The reason why we are deviating from the default 1000 Hz is that on
> our hardware we are using a loudspeaker which is rated for 2.7 kHz.
> That is, it will only sound at the specified volume and frequency if
> you feed it with a 2.7 kHz square wave. If you deviate from it, e.g.
> by using 1000 Hz, the output will be dim and squeaky. Worst case,
> SND_BELL would be completely silent on our system. So the only bell
> sound we can reliably generate on our system has 2.7 kHz.

OK, fair enough. Please address Rob's comments on binding and resend.

Also I am not sure why you needed to change the switch statement around,
you only need to replace 1000 with value from the attribute.

Oh, and please use device_property_*() API instead of of_*().

Thanks.

-- 
Dmitry
