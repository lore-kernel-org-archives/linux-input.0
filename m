Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1172E1722
	for <linux-input@vger.kernel.org>; Tue,  4 Aug 2026 05:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785821107; cv=none; b=FW4oIzEiWwJuoyzQJpKLVn+loXSSrYd6j+JcjlwWemLHi7WAw5JXLK59cMHEDZF72bx14JAoVmmDfWQpce1lw7ySH2ihMLoAqljyhYkANTwRlr7XNhCVoPlhbK2CeKi6qiZAl0fJEJUxz23woLatC5MB3X0DL9BpBtesaBmmXDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785821107; c=relaxed/simple;
	bh=mmwglf4UtvVil0QRLKOnjGSQ/l5rlXu/Ugbg3jrBdQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OOzHGjjPb5tlcmhCpZH+9r5tCjF9hsW3G0Ka0yV8sUffIlh064AxtLvPZ1FcyYVZLWrq6HMzaYMXbcGwmrLcB8jfmRXRXi51yy/B3nw03l1Ml560XBh5b+m/CP8HfIKVFbB5R90o3ERHyghBiILNZFpLl68y9FRjj/adDnAva8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ou8YG01E; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ou8YG01E"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84867f07d63so4842500b3a.2
        for <linux-input@vger.kernel.org>; Mon, 03 Aug 2026 22:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785821105; x=1786425905; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t6kvzdvm62iAzdXKiMHQHO64pAvvpog/HEHKw/8UdVs=;
        b=Ou8YG01EHv9F2nYdYK5SrOBUMEBsa0ot+P/ppADOvWeOFdDLJ/YbmlVBK+1vN7gy3N
         8qWDO+RrAiZHgN8d97f38gNs9mRz1dEtk/vWsnqAOEnSsdehSECvMe2lSQMnv6d050PI
         /JvR+fKE5MI0PENMM8nnGgLJIUpeql5RJCd7YDn3+ODJhKUvHI15sjjmeKRb7PxF3f+P
         pHHotVbpOFwBoXD/q5dkeoalM+Fw0qtgkpgzxKxHkl362cm9mPoFKr95D2ZTKqAeAL7h
         bH01fG9HDcTvePtPITy1H2ngHYDWjrHpb/hFSIIDbxEzQEY2a2dhhdKIruih+xXc24zj
         FAiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785821105; x=1786425905;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t6kvzdvm62iAzdXKiMHQHO64pAvvpog/HEHKw/8UdVs=;
        b=OlPJapIHnwYh1FOpo/u6nk2A1pqZv21tF56s2MTnDQo0MZsmexK/nGp5x790i0jX8d
         /39M8Va7Zjr5r4OYuIia+h6Gwe1NXPlZJg/5kmd6zUspDv0DMJjjuzCf4YTztXxJPzx5
         WAkmyw6mRKJZEAWKI4KzqeaVO8aOp7G317J65Mu0ffi4HABosFkE4CQy6lGgM9Zqg2IW
         uudcJGFZWmiyb1Q9ZR4olpouquWjOq7HzEH7T0409z4sobdVL9oguhOIu1+gF6iF9hyr
         sKb7BMQ71WKyORiXrhlPFp5ykZEJUwe5pwJfHW2wEYsn5xHxdpqrvYqYrNEDuFwhfK0k
         819g==
X-Gm-Message-State: AOJu0YxTG0+NX2DyumarYpJhz/rO2H8VmqD4en7R7IHAH/hOdr9W3hCH
	jc0pAUWGkQNTK7Y1834TnxuxALa+nsTPDEn9DzGxnbuwgwANp0XlbpH7
X-Gm-Gg: AR+sD11ZMhx8e9cXder3OJvM8Ny+9PL4nLmObdOOq2lh7p9TMdGPXQrxNVQH3eREMlK
	2fBGtXzC3sTw6vZIt2HAKJQBMFmlIDc5Fercwlp9jwA/FBr4J97OELUhH26FP3Va7W1D+gz3/ST
	AmYp2pWg8Q9uFsZSlxR6WBuV49tjdhbgrWKxgxBBGGsNVna5HYsIwoDOieAtvAXTGkruFwbDaAX
	9lB1zqowC+TyqL2/AblQQDdoxSM596no7xpUtAg4MOPRSM9gkcJnKg1clV17pS6lVjCTjvYlif6
	6P9IVfE06C/Lwmi9J2+FkfKPO9Frbb6+Wwxn/N9m408jtxzgpRtqzUAoEHOzUSC88I9ednIp2SY
	sMGN+4rf1ZEctregidHkUVy3QJ3wfdYAA/mFEK4JIQlpwXjHsyNzRqH8UMUmsFfQoXVe1wzbg3F
	7mZpcm6faSq0uLcc/n5QPn7KiNiXBO9EMSGXxUBlo7I74MuTvrq5/7P5d7xDup7A3GQJtGB4mAS
	JLo0zbTAThaj5aVEwfFgJRH4HNRHQ==
X-Received: by 2002:a05:6a21:9a4a:b0:3c3:bb40:790 with SMTP id adf61e73a8af0-3c92a8eff65mr13424705637.66.1785821105399;
        Mon, 03 Aug 2026 22:25:05 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:d109:cdba:8a20:74ad])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab1334cfsm41847138c88.1.2026.08.03.22.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 22:24:54 -0700 (PDT)
Date: Mon, 3 Aug 2026 22:24:51 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Richard Davies <richard@arachsys.com>
Cc: linux-input@vger.kernel.org, 
	Mathias Gottschlag <mgottschlag@gmail.com>, Hans de Goede <hansg@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: focaltech - use signed coordinates to prevent
 underflow
Message-ID: <anF3fpk_iVdkR3cV@google.com>
References: <am_tH_F938rK6ask@google.com>
 <anCXvKoIrqoPOtkz@users.org.uk>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anCXvKoIrqoPOtkz@users.org.uk>

On Mon, Aug 03, 2026 at 01:29:32PM +0000, Richard Davies wrote:
> Dmitry Torokhov wrote:
> > focaltech_finger_state stores finger coordinates x and y as unsigned
> > int. When processing relative packets, negative deltas can cause
> > unsigned integer underflow if the finger moves past the left or bottom
> > boundary of the touchpad, wrapping the coordinates to values near
> > UINT_MAX.
> > 
> > When clamping the coordinates in focaltech_report_state(), these
> > underflowed values are clamped against priv->x_max / priv->y_max instead
> > of 0, causing the cursor to jump erratically to the opposite edge of the
> > touchpad.
> 
> I agree this is theoretically possible. For what it's worth, I haven't
> actually experienced the cursor jumping to the opposite edge of the screen
> on my laptop. That might mean the relative packets are actually safe, e.g.
> generated internally from an absolute position.
> 
> > Change the coordinate variables and limits to signed int so that
> > negative values resulting from relative movements clamp correctly to 0.
> > 
> > Fixes: 05be1d079ec0 ("Input: psmouse - support for the FocalTech PS/2 protocol extensions")
> > Reported-by: sashiko-bot@kernel.org
> > Assisted-by: Antigravity:gemini-3.6-flash
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> > drivers/input/mouse/focaltech.c | 12 ++++++------
> > 1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/input/mouse/focaltech.c b/drivers/input/mouse/focaltech.c
> > index d3ad4af5aa09..c6f6540e3e29 100644
> > --- a/drivers/input/mouse/focaltech.c
> > +++ b/drivers/input/mouse/focaltech.c
> > @@ -78,8 +78,8 @@ struct focaltech_finger_state {
> > 	 * Absolute position (from the bottom left corner) of the
> > 	 * finger.
> > 	 */
> > -	unsigned int x;
> > -	unsigned int y;
> > +	int x;
> > +	int y;
> > };
> > 
> > /*
> > @@ -108,7 +108,7 @@ struct focaltech_hw_state {
> > };
> > 
> > struct focaltech_data {
> > -	unsigned int x_max, y_max;
> > +	int x_max, y_max;
> > 	struct focaltech_hw_state state;
> > };
> > 
> > @@ -126,14 +126,14 @@ static void focaltech_report_state(struct psmouse *psmouse)
> > 		input_mt_slot(dev, i);
> > 		input_mt_report_slot_state(dev, MT_TOOL_FINGER, active);
> > 		if (active) {
> > -			unsigned int clamped_x, clamped_y;
> > +			int clamped_x, clamped_y;
> > 			/*
> > 			 * The touchpad might report invalid data, so we clamp
> > 			 * the resulting values so that we do not confuse
> > 			 * userspace.
> > 			 */
> > -			clamped_x = clamp(finger->x, 0U, priv->x_max);
> > -			clamped_y = clamp(finger->y, 0U, priv->y_max);
> > +			clamped_x = clamp(finger->x, 0, priv->x_max);
> > +			clamped_y = clamp(finger->y, 0, priv->y_max);
> > 			input_report_abs(dev, ABS_MT_POSITION_X, clamped_x);
> > 			input_report_abs(dev, ABS_MT_POSITION_Y,
> > 					 priv->y_max - clamped_y);
> 
> If it's allowed and race-free to change finger->{x,y} in
> focaltech_report_state, then you might fix the Sashiko [High] issue on this
> patch by just doing:
> 
> finger->x = clamp(finger->x, 0, priv->x_max);
> finger->y = clamp(finger->y, 0, priv->y_max);
> 
> not having the clamped_{x,y} variables at all, and updating the two
> input_report_abs lines below to use finger->{x,y}

Good idea, thank you. I'll update and apply.

Thanks.

-- 
Dmitry
