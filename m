Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A723ADB99
	for <linux-input@vger.kernel.org>; Mon, 21 Sep 2026 19:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790019323; cv=none; b=HbqNh3u8LSYQdzij3nH6ijFo952osngDaxpDAH3Q6l3j4YWHCC1uSQ+iHa3/tvkH9didZkT5Q9t7olhV5zC6uklsHIXUv7zfL1oRO/JZTwjm1YzY8t6TzNqBl037GJ1KArqm5sWqgxzd80AE2ii+n5ixFBC03QfO1jPIIgU8M4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790019323; c=relaxed/simple;
	bh=91BpiKRhcNi1oMd/UANA8vqZpXHfK9YQo9UgwaLw3GU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uFDt9Glcu9lbuIKvh83aUlD+wz6rO9wrfDF2mrP7eNzuh6A4pM8myYE+/Dp/HS/8sRJMT0/pgql4mPeNMxmmcP1dgYSXQ/aFUnNgYFozH4kG6eohcr+9yCybPu1lt/7qqkDlTSAmHKhcBGMIbDlL9A8pVTfFSthLxEIS4yvlaHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZedd+hX; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZedd+hX"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea4bfd1so2301804a12.0
        for <linux-input@vger.kernel.org>; Mon, 21 Sep 2026 12:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790019321; x=1790624121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DVG44XaWD5VRhIgKZtC9m13XRRvje7+lB6Y1xmS7mQI=;
        b=BZedd+hXG+IvgdlJY+Odc5OL5Mz05SKEz8WZZXbTMGy+8naGt3b4Rkew9r/WHcUpJr
         sop/v5rgJs/f1XcWbx38YFwk9Xjpjbi2Yu8kpcAN/DY4eKLmRfhygooH2Keg2HudwDG2
         XC2phHioeooHN28pmiEgfVoPDKaWmEkZ1Vm7z+e/5ewjs9mTuRMVLH9MDWnk83oBspZe
         W9ViLRB/NDaM3Ye5c40LfYz02LTqMbkvf6n/FqZO5FiGOIhFNmBpEEYciHWFOkFNR8IG
         MjUHcEfgqC+0KE7uOkMgUa5XWhUGHtCLKKhTlXhl/YAwlz1rja4b55RIBkZmrfmz7vgh
         6jYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790019321; x=1790624121;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DVG44XaWD5VRhIgKZtC9m13XRRvje7+lB6Y1xmS7mQI=;
        b=O00NC9Clp4Wry1BXwt2pyNPztrX5vvnUEctJKwgzcTjvrRD6+8HbUndV0AUR9BhnmL
         Y8rgS4+F1krgEjc9Fubj0YSdiyxR/1vEikZLReNz5/ScwU+YXgUGbjKWAH8vVMFhYRCe
         MtzpOifN2Wr88GCakSoTJnC+qdzaeSI8uyiZY4i8Rf2CF6j/xdnmts2hElZ3gWlRJl4Y
         M/mTirumCgZGObzo1x9oRqFayT2+J5ILjYrYIYx1WluG8/LHWpwrMbApI+G20CsTWMbN
         t0g+HOlaYZ+XzSQKq6xDZ5fmZtB6zjuhd+eTRRdmN5KsOuq1dt3OJDzPBuUYqI8Hb6V4
         JusA==
X-Forwarded-Encrypted: i=1; AKwUvBwOE12tVIxOj028KTVqnM/iOWqxgKhazsdALt8ldh4ieDCKzpW70Gq2Fgtdm6UYeTxww9zNN9WBB53P8w==@vger.kernel.org
X-Gm-Message-State: AFuF++lTjQNO+hvx4lVskJ7ykFANtImlRSmoJ2k8aTSGKTx0U5DZbSMB
	zVkbtUcm1gXBzchz0sI/4iXT34C/aeAqTY5K/F6iZQe/0V52fSwiYGJh
X-Gm-Gg: AYBFou37o5ax6Yoh2/j8O6UfISsRp3ppQpcv9H9ca1zuKXFRTwRzh/2PX7G4cp/sB6s
	SYrY+ItNpzKnAJokQgXHed+WBKZZ+xksMKIsX9mczSRXeygC0C+3cS4VwWOTntNz2b1PVDIZOdl
	KEOFxd+9MxyXb3jtCuaS4pKjcgCgrlGVZB71jKRYA3ZMgTdPpV44uBbr6DKnYvhPwV/bwxCetGF
	LjgohZkiQ6pzQmmqy+PbZ+AX2sAEal8mhHtrN5I1LATcOdsVdGnGH8UpA0vVurlrk9kIFHw8Wx/
	IEHPRO+lwjcQZP5dLt59wBIG+RYYzHVOa/1rc3Fd9gXw4ikYNcUysS3KERrQBWiUkci0QX6H52s
	jSIg9m8vpRh6z6qw8HC6pYNVbhmhSXVzJuIidT05YPavJ7efs0jccmBnlqHA/zZ38/3oZASwTW9
	kFSgpIgWJSwYxeQSJqjCxnS45iF5CBcTR+tmrJZ3jkzMsrEVRa1ECCXYeXUgL6apT4dOjFZD91p
	k3lkeqOwVG2zqo5VIEFtERMqeGniP+zyBGlcJ3DrB1VObScO7E=
X-Received: by 2002:a05:6a21:6b05:b0:3da:c2f5:a2aa with SMTP id adf61e73a8af0-3dd8c3323a9mr19869710637.18.1790019321421;
        Mon, 21 Sep 2026 12:35:21 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:e1a7:4f7b:11d4:34fa])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144d55cef9bsm21067568c88.10.2026.09.21.12.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 12:35:20 -0700 (PDT)
Date: Mon, 21 Sep 2026 12:35:16 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>, 
	Kendall Willis <k-willis@ti.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, s-kochidanadu@ti.com, 
	a-kaur@ti.com, s-tripathi1@ti.com, vishalm@ti.com, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: input: gpio-keys: add pinctrl states
Message-ID: <arGGhvIieis2_sZ9@google.com>
References: <20260912-upstream-gpio-wakeup-v1-0-f0e12484b836@ti.com>
 <20260912-upstream-gpio-wakeup-v1-1-f0e12484b836@ti.com>
 <20260914-unbreakable-competent-beluga-efb5ad@quoll>
 <20260915164819.nlgpuvf37rhzgc66@uda0506412>
 <dec4f6e1-115e-46dd-8fb9-a3c67f1a8811@kernel.org>
 <da881fb0-93da-4d75-88da-8898b2c734eb@kernel.org>
 <20260915174103.ad6tjy6w6s24h2yc@uda0506412>
 <20260916-dancing-loud-guan-fbb1eb@quoll>
 <DLGUOGCLFAI9.2JSS4DCFRYTNI@baylibre.com>
 <dfd82438-1c40-42b7-8a90-bd349a476489@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfd82438-1c40-42b7-8a90-bd349a476489@kernel.org>

On Sun, Sep 20, 2026 at 12:24:32PM +0200, Krzysztof Kozlowski wrote:
> On 16/09/2026 17:36, Markus Schneider-Pargmann wrote:
> > On Wed Sep 16, 2026 at 9:17 AM CEST, Krzysztof Kozlowski wrote:
> >> On Tue, Sep 15, 2026 at 12:41:03PM -0500, Kendall Willis wrote:
> >>> On 19:07-20260915, Krzysztof Kozlowski wrote:
> >>>> On 15/09/2026 19:05, Krzysztof Kozlowski wrote:
> >>>>> On 15/09/2026 18:48, Kendall Willis wrote:
> >>>>>> On 12:13-20260914, Krzysztof Kozlowski wrote:
> >>>>>>> On Sat, Sep 12, 2026 at 04:33:53PM -0500, Kendall Willis wrote:
> >>>>>>>> Document pinctrl properties on the gpio-keys device node. By using the
> >>>>>>>> wakeup pinctrl state, the pins are able to wakeup the system from a
> >>>>>>>> low-power state. The default pinctrl state describes the default pin
> >>>>>>>> configuration.
> >>>>>>>>
> >>>>>>>> Signed-off-by: Kendall Willis <k-willis@ti.com>
> >>>>>>>> ---
> >>>>>>>>  Documentation/devicetree/bindings/input/gpio-keys.yaml | 16 ++++++++++++++++
> >>>>>>>>  1 file changed, 16 insertions(+)
> >>>>>>>>
> >>>>>>>> diff --git a/Documentation/devicetree/bindings/input/gpio-keys.yaml b/Documentation/devicetree/bindings/input/gpio-keys.yaml
> >>>>>>>> index cc78c2152921308fe0cad3e29ca78a5fad08f066..b554933e93412d8b6c2ec401dc1e1eeff57d4190 100644
> >>>>>>>> --- a/Documentation/devicetree/bindings/input/gpio-keys.yaml
> >>>>>>>> +++ b/Documentation/devicetree/bindings/input/gpio-keys.yaml
> >>>>>>>> @@ -22,6 +22,22 @@ properties:
> >>>>>>>>  
> >>>>>>>>    poll-interval: true
> >>>>>>>>  
> >>>>>>>> +  pinctrl-0:
> >>>>>>>> +    description: Default pinctrl state
> >>>>>>>> +
> >>>>>>>> +  pinctrl-1:
> >>>>>>>> +    description: Wakeup pinctrl state
> >>>>>>>> +
> >>>>>>>> +  pinctrl-names:
> >>>>>>>> +    description:
> >>>>>>>> +      When present should contain at least "default" describing the default pin
> >>>>>>>> +      states. The second state called "wakeup" describes the pins in their
> >>>>>>>> +      wakeup configuration required to exit sleep states.
> >>>>>>>> +    minItems: 1
> >>>>>>>> +    items:
> >>>>>>>> +      - const: default
> >>>>>>>> +      - const: wakeup
> >>>>>>>
> >>>>>>> This will introduce new warnings, which should be being fixed in this
> >>>>>>> patchset (e.g. at91-kizbox3-hs.dts).
> >>>>>>>
> >>>>>>
> >>>>>> Will fix the binding to work with current device trees.
> >>>>>>
> >>>>>>> But nevertheless, isn't second state the sleep state? How can you
> >>>>>>> configure pins for the wakeup state - like being in the wakeup? You
> >>>>>>> configure the pins for given state, which will be a system suspend, so
> >>>>>>> sleep?
> >>>>>>>
> >>>>>>
> >>>>>> The sleep state usually refers to putting the pins in a state to save
> >>>>>> power. The wakeup pinctrl state is for putting the pins in a state to
> >>>>>> allow wakeup from suspend for that device. Both 'sleep' and 'wakeup'
> >>>>>> are for system suspend, but they fill different functions. The CAN
> >>>>>> subsystem also uses the 'wakeup' state in addition to the 'sleep' state
> >>>>>> [1].
> >>>>>
> >>>>> So you mean sleep would be a separate state? But then aren't both
> >>>>> exactly the same states? IOW, if device is wakeup-source, it will have
> >>>>> for "sleep" state pin configuration allowing to wakeup.
> >>>
> >>> The 'sleep' and 'wakeup' pin states are both used for suspend. They
> >>> would just be used separately since only one could be used at a time.
> >>> The reason 'wakeup' is separated out is because it is more specific for
> >>> allowing wakeup from the device.
> >>
> >> If they cannot be used together, then it is the same state.
> > 
> > If I understand this patch correctly, 'sleep' is not relevant here.
> > But 'sleep' and 'wakeup' serve different purposes and can be
> > used/defined together in a single device in the devicetree:
> >  - 'sleep' describes the pin state during suspend if wakeup is not
> >    enabled by the user or there is no 'wakeup' pin state defined.
> >  - 'wakeup' describes the pin state during suspend if wakeup is enabled
> >    by the user.
> > If the user enables wakeup, 'wakeup' is the relevant state and otherwise
> > 'sleep'. Which one applieas is a runtime decision of the the user.
> > 
> > I introduced these two states for m_can for that reason. This was
> > discussed here:
> >   https://lore.kernel.org/r/DCD1YPX4T779.ADK4JCGW1MU7@baylibre.com
> > 
> > And then reviewed/applied in v10:
> >   https://lore.kernel.org/r/175993598226.3512549.5295923279078928995.robh@kernel.org
> 
> So we seems to be discussing same issue again, because commit msg lacks
> proper explanations.
> 
> The problem and difference here is that there is no sleep state.

Isn't there? The wakeup can be controlled from userspace and can't we
possible have 2 distinct pin control states, one for when a device is a
potential wakeup source, and another one when the device is in "off"
state while system is asleep?

Thanks.

-- 
Dmitry
