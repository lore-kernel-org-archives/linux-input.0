Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEFB37F72C;
	Wed, 12 Aug 2026 07:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786518346; cv=none; b=ADKj/UCHuQrzdMr2jgpqLaQINmlbJ0mSj8x4h8oeTSFxDfegm+I8G+YdxqPpibBexQcnhWeik1TtD83Ba8oc8HRY5ZG9XZ7P005cLY2prOcT+Tcqck0vbKT3Sw3qgfcH8UNrSeAoDpJ1KzGMAUSDdtIZWhwh3lhlLk1LFuCbpKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786518346; c=relaxed/simple;
	bh=7UlxsdRlV4w5gl4M2UH6ry+EMPWAtc40il47x5PwHs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aG0J72QX0fsDhfskA6Gi1/DF9MXJYh5k5pHxQr4WxQ4pDwRhhtgB5cg2R520WdAJusyGONMeN/1cu1RmxBuC1WQnqNkWQL48BZ83zVg0Y5cCIkmVI9Dzc1NnTXrrQdw+aJO8Maoh/zfqu7ey1jat2UDAJEmwat5lTWVlWea7neQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n8zyaBHH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n8zyaBHH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E26221F000E9;
	Wed, 12 Aug 2026 07:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786518344;
	bh=Kh9ZpyCQgq0l61AlK2sVhdIZ+M3D01Umafb2ZdVQdXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=n8zyaBHHslwAvamLVyyinn3wzZzLnkgyog8ayM4pAxGiDGYU5EGePCLETb09Xn0Kg
	 d2Tnkf3OG1psjBpgL7Y1pD1qST0duaf04nS0mbr2r006+C8WidZRjw0nPiTlqPn7UC
	 CryZz93kKsw+7JfGYTeXQvb4HW1vQ+4UQg5Fx/ieLDMvmqfg+Zg02fzWHFuuz6MLMk
	 ogzah9gDq/cyfVZE6JaR3mfGWDfwya3CvRfTcSxfpEgpJZss5sCkvAfvd9HY2jW4d/
	 IVO8lXoCjm2lNiI9WRTikF3/oOnPBnUbKoxIEPeWQgi8mABtn2xxsGY5QhiV8PK6T/
	 ig88BcV0HIpTg==
Date: Wed, 12 Aug 2026 08:05:39 +0100
From: Lee Jones <lee@kernel.org>
To: Jason Gerecke <killertofu@gmail.com>
Cc: Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Aaron Skomra <aaron.skomra@wacom.com>,
	Peter Hutterer <peter.hutterer@who-t.net>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/4] HID: wacom: Advertise SW_MUTE_DEVICE capability
 prior to registration
Message-ID: <20260812070539.GD1072730@google.com>
References: <20260804103209.1496683-1-lee@kernel.org>
 <20260810105633.GS2869284@google.com>
 <CANRwn3RMhVU3umEWx+SauHTBNwNkQuQ8tos-goA1Q=SuMo29RQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANRwn3RMhVU3umEWx+SauHTBNwNkQuQ8tos-goA1Q=SuMo29RQ@mail.gmail.com>

On Tue, 11 Aug 2026, Jason Gerecke wrote:

> On Mon, Aug 10, 2026 at 3:57 AM Lee Jones <lee@kernel.org> wrote:
> >
> > Jason,
> >
> > Can you confirm that you've seen this new version please?
> >
> > [intentional top-post]
> >
> >
> > On Tue, 04 Aug 2026, Lee Jones wrote:
> >
> > > Input subsystem guidelines require that device capabilities are advertised
> > > before the input device is registered.  The Wacom driver was violating
> > > this by advertising the SW_MUTE_DEVICE capability post-registration in
> > > wacom_set_shared_values() (and duplicating it in device-specific setup
> > > cases).
> > >
> > > Resolve this by moving the SW_MUTE_DEVICE capability setup to
> > > wacom_setup_touch_input_capabilities() for all touch devices that support
> > > it, including composite USB generic touch devices.
> > >
> > > Additionally, replace the lookup-dependent
> > > 'wacom_wac->shared->touch->product' references with 'hdev->product'
> > > inside wacom_setup_touch_input_capabilities() as 'hdev' is already
> > > available and represents the touch device itself.
> > >
> > > Fixes: d2ec58aee8b1 ("HID: wacom: generic: support generic touch switch")
> > > Signed-off-by: Lee Jones <lee@kernel.org>
> > > ---
> > >
> > > v4 -> v5: New patch used to split out SW_MUTE_DEVICE as per Jason's request
> > > v5 -> v6: Unconditionally advertise SW_MUTE_DEVICE on generic touch devices
> > > v6 -> v7: Only advertise SW_MUTE_DEVICE on composite USB generic touch devices
> > >
> > >  drivers/hid/wacom_sys.c | 23 +++++++++++++++++------
> > >  drivers/hid/wacom_wac.c | 19 +++++++++++--------
> > >  2 files changed, 28 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
> > > index 0eafa483b7f7..92b73ed0028f 100644
> > > --- a/drivers/hid/wacom_sys.c
> > > +++ b/drivers/hid/wacom_sys.c
> > > @@ -2359,12 +2359,6 @@ static void wacom_set_shared_values(struct wacom_wac *wacom_wac)
> > >                       wacom_wac->shared->is_touch_on = true;
> > >       }
> > >
> > > -     if (wacom_wac->shared->has_mute_touch_switch &&
> > > -         wacom_wac->shared->touch_input) {
> > > -             set_bit(EV_SW, wacom_wac->shared->touch_input->evbit);
> > > -             input_set_capability(wacom_wac->shared->touch_input, EV_SW,
> > > -                                  SW_MUTE_DEVICE);
> > > -     }
> > >  }
> > >
> > >  static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
> > > @@ -2414,6 +2408,23 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
> > >       wacom_retrieve_hid_descriptor(hdev, features);
> > >       wacom_setup_device_quirks(wacom);
> > >
> > > +     if (features->type == HID_GENERIC &&
> > > +         (features->device_type & WACOM_DEVICETYPE_TOUCH)) {
> > > +             if (wacom->usbdev && wacom->usbdev->actconfig &&
> > > +                 wacom->usbdev->actconfig->desc.bNumInterfaces > 1) {
> > > +                     /*
> > > +                      * Heuristic: Composite USB devices (like tablets with
> > > +                      * pen/pad + touch) likely have a touch mute switch.
> > > +                      * We flag it here to advertise the capability before
> > > +                      * registration. We also set is_soft_touch_switch to
> > > +                      * default touch to ON in case there is no physical
> > > +                      * switch.
> > > +                      */
> > > +                     wacom_wac->has_mute_touch_switch = true;
> > > +                     wacom_wac->is_soft_touch_switch = true;
> > > +             }
> > > +     }
> > > +
> 
> Apologies for the delay, Lee.
> 
> [ Begin ramble ]
> 
> This probably isn't a half-bad heuristic. I'm a bit hesitant to sign
> off on it, mostly because I don't like the idea of the driver
> advertising the existence of non-existent hardware.
> 
> My understanding is that it is theoretically allowable to change
> capabilities post-registration (assuming we take due care to spinlock
> relevant structures). The problem with doing so, however, is that if
> userland queries the capabilities before we make the change, that it
> will be stuck with an incorrect set. Software could theoretically
> re-issue EVIOCGBIT ioctls at a later point in time to refresh
> capabilities, but if we're honest that doesn't actually happen.
> 
> It feels like we're in a situation where we either:
> 
> A. Over-declare device capabilities on some devices (mostly older ones
> that didn't have a touch switch)
> 
> -- or --
> 
> B. Have devices with under-declared capabilities if userland opens
> them fast enough
> 
> The touch switch capability lets userland know to expect switch events
> and to potentially offer some kind of software display of its state.
> Its presence or absence is not critical since the switch state can
> often be observed in other ways (physical hardware switch location) or
> toggled back into a disabled state even if not immediately observable.
> It's probably marginally better to err on providing state information
> in situations where controls don't actually exist, but not by much.
> 
> [ End ramble ]
> 
> With all of that out of the way, I guess that I've convinced myself
> that this is probably acceptable.
> 
> The only remaining nitpick I can identify looking at this again is
> that the hunks that replace 'wacom_wac->shared->touch->product' with
> 'hdev->product' should really be in their own standalone cleanup patch
> rather than in this (slightly-) behavior modifying one.
> 
> Address that one nitpick and I'll send out my reviewed-by for the two
> new patches. Apologies again for my many delays... This should be the
> last one :)

Okay, leave it with me.

-- 
Lee Jones
