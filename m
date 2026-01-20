Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E2E42980D;
	Tue, 20 Jan 2026 13:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768917409; cv=none; b=pI8vq+/dIj1dN6bxAIdoMFr5eo2Vkem38fHHPoqp4MKx1KV1kQWkW+oFWY2f9Ggb7cJLg2TaIkP4FIS5lyPKyxZru9DKnMa8QEqLlEXpdl1GJ0sh9DumliM26HDofQ9lRHhBiQWalR5OUPYKcIX1LI3jswqTWIUvKhtnR1mtAvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768917409; c=relaxed/simple;
	bh=ysV0jAr5+ezx4+/u76UogfGXVT+d99ZUDvuUIgUVcdM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=IL1CC/jbbC9evBpV4UTFPYzvY4THg2OxkVM/K8Z0mlIDxQxO+k43kX/iv++VL/pn2modCYNFtWbXGfH7qO5V//4CLSuABbxofwwVmbxNxXe0ohIs558IqrLwGaRuSnHjXd7tSiG1Hx9FS+BtKcc/UzL7kf083PIWGPd04Acxn2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mn8xyyqk; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mn8xyyqk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768917406; x=1800453406;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ysV0jAr5+ezx4+/u76UogfGXVT+d99ZUDvuUIgUVcdM=;
  b=mn8xyyqklXF+I2VDxOtt9+2ruJqQosO7Fa4X8KwY3lCyDqapuuENg8op
   oKddnC8jXmCfMZSOmnmbIR6fGcI0trFGoULVVSEhmd5+b1OJ30xx41nxd
   IOrkvD0asj0EQrXty/qrmQnR5kgZ+ILZ+gWZGqqdlItktykO19TOsAbwx
   FQ0JF9DkVW1hqCiyyO3MERLPXT7elHHANzaWbIzwbsP+C5XWbMGUfO3QK
   SvOhJ/an9KPcfSC5B5ZAvIQ9qDLn8i/z7IQJF4+IysIk2g/Jt75HKPlk4
   KHSeszRcONgLgsCLY9HmTPtExFPitfleTfZmONS6wpGuSNO2hNH+F6Kn9
   w==;
X-CSE-ConnectionGUID: TKjfhFH3Sx6Ttv9ISKxq3g==
X-CSE-MsgGUID: KXbLVrCnQsOknvICMIS3RA==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="57682686"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="57682686"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 05:56:45 -0800
X-CSE-ConnectionGUID: 81MHjegjT6O8l7hbLOc2jw==
X-CSE-MsgGUID: RY29hClxS/G7wPRZyFgkAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="205932811"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.10])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 05:56:40 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 20 Jan 2026 15:56:37 +0200 (EET)
To: Antheas Kapenekakis <lkml@antheas.dev>
cc: Denis Benato <denis.benato@linux.dev>, platform-driver-x86@vger.kernel.org, 
    linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
    Corentin Chary <corentin.chary@gmail.com>, 
    "Luke D . Jones" <luke@ljones.dev>, Hans de Goede <hansg@kernel.org>
Subject: Re: [PATCH v11 02/11] HID: asus: initialize additional endpoints
 only for legacy devices
In-Reply-To: <CAGwozwF--y3vsqhdqYFV_x1ff7jfSkYaQHeV1OV70yue7Huk=A@mail.gmail.com>
Message-ID: <89a67ace-6fef-72e0-4ef3-be828dd85e3d@linux.intel.com>
References: <20260116133150.5606-1-lkml@antheas.dev> <20260116133150.5606-3-lkml@antheas.dev> <14407ba9-34f1-4114-bfb3-043b53ea7769@linux.dev> <CAGwozwGyUpBq4GGvyDHj089a9-vxNOnqgSBys3-CC_+tKDywaA@mail.gmail.com> <fe66c416-161c-489e-a38f-9dc7729c6ed7@linux.dev>
 <CAGwozwESNrQZ240_qDMf1pdpCRXooxstGcqP10cGp=q-F_SrAQ@mail.gmail.com> <8102eb26-5206-49e6-a994-a9d3ea480255@linux.dev> <CAGwozwH71LDiBFM-Ro9UpZNy29C6HHwCNZjwCS3F1hMfuUXZ4g@mail.gmail.com> <be8ba636-ae07-4d42-88ca-57ecf10b7dae@linux.dev>
 <CAGwozwGdhu_chetK6uQ=FXctC1D8LABj5QxVff1B486EKYSLug@mail.gmail.com> <e4349b27-86e1-41d6-864f-5ad6d353dc46@linux.dev> <CAGwozwF--y3vsqhdqYFV_x1ff7jfSkYaQHeV1OV70yue7Huk=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 17 Jan 2026, Antheas Kapenekakis wrote:
> On Sat, 17 Jan 2026 at 18:05, Denis Benato <denis.benato@linux.dev> wrote:
> > On 1/17/26 17:16, Antheas Kapenekakis wrote:
> > > On Sat, 17 Jan 2026 at 17:12, Denis Benato <denis.benato@linux.dev> wrote:
> > >> On 1/17/26 17:10, Antheas Kapenekakis wrote:
> > >>> On Sat, 17 Jan 2026 at 16:13, Denis Benato <denis.benato@linux.dev> wrote:
> > >>>> On 1/17/26 16:07, Antheas Kapenekakis wrote:
> > >>>>> On Sat, 17 Jan 2026 at 14:51, Denis Benato <denis.benato@linux.dev> wrote:
> > >>>>>> On 1/17/26 00:10, Antheas Kapenekakis wrote:
> > >>>>>>> On Fri, 16 Jan 2026 at 21:44, Denis Benato <denis.benato@linux.dev> wrote:
> > >>>>>>>> On 1/16/26 14:31, Antheas Kapenekakis wrote:
> > >>>>>>>>
> > >>>>>>>>> Currently, ID1/ID2 initializations are performed for all NKEY devices.
> > >>>>>>>>> However, ID1 initializations are only required for RGB control and are
> > >>>>>>>>> only supported for RGB capable devices. ID2 initializations are only
> > >>>>>>>>> required for initializing the Anime display endpoint which is only
> > >>>>>>>>> supported on devices with an Anime display. Both of these
> > >>>>>>>>> initializations are out of scope for this driver (this is a brightness
> > >>>>>>>>> control and keyboard shortcut driver) and they should not be performed
> > >>>>>>>>> for devices that do not support them in any case.
> > >>>>>>>>>
> > >>>>>>>>> At the same time, there are older NKEY devices that have only been
> > >>>>>>>>> tested with these initializations in the kernel and it is not possible
> > >>>>>>>>> to recheck them. There is a possibility that especially with the ID1
> > >>>>>>>>> initialization, certain laptop models might have their shortcuts stop
> > >>>>>>>>> working (currently unproven).
> > >>>>>>>>>
> > >>>>>>>>> For an abundance of caution, only initialize ID1/ID2 for those older
> > >>>>>>>>> NKEY devices by introducing a quirk for them and replacing the NKEY
> > >>>>>>>>> quirk in the block that performs the inits with that.
> > >>>>>>>>>
> > >>>>>>>>> In addition, as these initializations might not be supported by the
> > >>>>>>>>> affected devices, change the function to not bail if they fail.
> > >>>>>>>>>
> > >>>>>>>>> Acked-by: Benjamin Tissoires <bentiss@kernel.org>
> > >>>>>>>>> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> > >>>>>>>>> ---
> > >>>>>>>>>  drivers/hid/hid-asus.c | 16 ++++++----------
> > >>>>>>>>>  1 file changed, 6 insertions(+), 10 deletions(-)
> > >>>>>>>>>
> > >>>>>>>>> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> > >>>>>>>>> index 323e6302bac5..dc7af12cf31a 100644
> > >>>>>>>>> --- a/drivers/hid/hid-asus.c
> > >>>>>>>>> +++ b/drivers/hid/hid-asus.c
> > >>>>>>>>> @@ -90,6 +90,7 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
> > >>>>>>>>>  #define QUIRK_ROG_NKEY_KEYBOARD              BIT(11)
> > >>>>>>>>>  #define QUIRK_ROG_CLAYMORE_II_KEYBOARD BIT(12)
> > >>>>>>>>>  #define QUIRK_ROG_ALLY_XPAD          BIT(13)
> > >>>>>>>>> +#define QUIRK_ROG_NKEY_LEGACY                BIT(14)
> > >>>>>>>> These past days I have taken a look at new 2025 models and they do make use of ID2,
> > >>>>>>>> and won't do harm sending ID1 either. I think you can safely remove the if and send regardless.
> > >>>>>>> Hi Denis,
> > >>>>>>> it is not the responsibility of this driver. ID2 is used by Anime
> > >>>>>>> models. It is a concession to make sure that we do not cause a
> > >>>>>>> regression that will cause warnings for a lot of users.
> > >>>>>> Who decided it is a concession?
> > >>>>> I would rather remove the extra calls unless they are shown to be
> > >>>>> needed, which they might be for these PIDs.
> > >>>> They are needed on older laptop and to not regress userspace.
> > >>>>
> > >>>> You just named _LEGACY an usb pid that is not legacy.
> > >>>>> The quirk is named legacy because we can't retest these devices. If we
> > >>>>> can, then we could remove the quirk and the inits if not needed.
> > >>>> We can't retest every device, and that pid is used in pre-2021 models,
> > >>>> and these are the unknown, I am criticizing the name of the quirk here,
> > >>>> not what it does.
> > >>> If you can test whether your device needs them that would be great.
> > >> That is pointless.
> > >>>> I am also questioning if the quirk is even needed since sending
> > >>>> those commands to (at least) recent hardware that doesn't use
> > >>>> those endpoints carries no downsides, while removing them
> > >>>> surely does.
> > >>> We have not found a device yet that needs them. I do not want to keep
> > >>> sending unneeded commands. It could cause obscure bugs or interfere
> > >>> with userspace software such as the one you maintain. So at least for
> > >>> new hardware that is possible to test we should remove them.
> > >> There is new hardware that needs them, as I said, including 2025 models.
> > > I was not aware of that. As far as I know they are not needed. Do you
> > > have a bug report with a specific laptop model I can look at?
> > There is current effort to integrate commands that requires those
> > initializations on 2025 laptop, why would I strip out a command
> > that I already know is required anyway?
> 
> Hi,
> yes ID1 is required for RGB, I have a draft patch for it that would
> lazily do it if RGB is supported.
> 
> I recall now a previous discussion about it being required for some
> laptop shortcuts but we never found a laptop that needs it so I forgot
> 
> > No, this is not the way to go to knowingly and willingly cause
> > troubles (both known and unknown) to others just because
> > you think it's better this way.
> >
> > Change the name of _LEGACY to something else, have this accepted
> > and then if I see it's appropriate  to remove the if and send those
> > regardless I will.
> 
> Sure, up to you if you want to change the name. What would you like it
> be? I would like this series to merge

Can you name it e.g. something that should be neutral such as:

QUIRK_ROG_NKEY_ID1_ID2_INIT

I'm not sure if ROG NKEY should still be included into the name based on 
what Denis mentioned about recent models but at least it gets rid of the 
"legacy" connotation. If wider scope is necessary you could use just
QUIRK_ID1_ID2_INIT.

--
 i.
