Received: from users.org.uk (users.org.uk [91.203.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C68413782;
	Mon,  3 Aug 2026 13:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.203.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785763780; cv=none; b=gXKyPzDGuA4p3FAHw9xnPglrJihnCUVvvu7W+TfrWXGdjqNbkkGFBs7VD248JOQRTJqN0H+VppsKwykTsF4nhrgGZd8RZTOGTOOpx9wH8w3STBoc6moRL70Moi35aXdTCRHwei0N+xagNmgAVolMj6QlRBefPcHNrYw7jbHBlxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785763780; c=relaxed/simple;
	bh=8qmPTmR/SS454wkHrPpoztQvcL7q7oP+XSqTzHPiVd8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=atWI7B9DI6n9D1ucXvBOZrhTRKN6/Wp1cqJEfrLTHYbW5ae60IrdQgQ1y9qOEQjGOCda4QHQQ16Wyol5nlXqCkrPSCBCbcfVG1/ba4CkA6Bns0g4cqlgCr8Zs8ToMFK+V53XD/6DAu/vVp04ocxext6Aj8vezR+h1cezWUFbB6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arachsys.com; spf=pass smtp.mailfrom=arachsys.com; arc=none smtp.client-ip=91.203.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arachsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arachsys.com
Received: from richard by users.org.uk with local
	(envelope-from <richard@arachsys.com>)
	id 1wqsjU-000000001qA-0Zh8;
	Mon, 03 Aug 2026 13:29:32 +0000
Date: Mon, 3 Aug 2026 13:29:32 +0000
From: Richard Davies <richard@arachsys.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: Mathias Gottschlag <mgottschlag@gmail.com>,
	Hans de Goede <hansg@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: focaltech - use signed coordinates to prevent
 underflow
Message-ID: <anCXvKoIrqoPOtkz@users.org.uk>
References: <am_tH_F938rK6ask@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <am_tH_F938rK6ask@google.com>

Dmitry Torokhov wrote:
>focaltech_finger_state stores finger coordinates x and y as unsigned
>int. When processing relative packets, negative deltas can cause
>unsigned integer underflow if the finger moves past the left or bottom
>boundary of the touchpad, wrapping the coordinates to values near
>UINT_MAX.
>
>When clamping the coordinates in focaltech_report_state(), these
>underflowed values are clamped against priv->x_max / priv->y_max instead
>of 0, causing the cursor to jump erratically to the opposite edge of the
>touchpad.

I agree this is theoretically possible. For what it's worth, I haven't 
actually experienced the cursor jumping to the opposite edge of the screen 
on my laptop. That might mean the relative packets are actually safe, e.g. 
generated internally from an absolute position.

>Change the coordinate variables and limits to signed int so that
>negative values resulting from relative movements clamp correctly to 0.
>
>Fixes: 05be1d079ec0 ("Input: psmouse - support for the FocalTech PS/2 protocol extensions")
>Reported-by: sashiko-bot@kernel.org
>Assisted-by: Antigravity:gemini-3.6-flash
>Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>---
> drivers/input/mouse/focaltech.c | 12 ++++++------
> 1 file changed, 6 insertions(+), 6 deletions(-)
>
>diff --git a/drivers/input/mouse/focaltech.c b/drivers/input/mouse/focaltech.c
>index d3ad4af5aa09..c6f6540e3e29 100644
>--- a/drivers/input/mouse/focaltech.c
>+++ b/drivers/input/mouse/focaltech.c
>@@ -78,8 +78,8 @@ struct focaltech_finger_state {
> 	 * Absolute position (from the bottom left corner) of the
> 	 * finger.
> 	 */
>-	unsigned int x;
>-	unsigned int y;
>+	int x;
>+	int y;
> };
>
> /*
>@@ -108,7 +108,7 @@ struct focaltech_hw_state {
> };
>
> struct focaltech_data {
>-	unsigned int x_max, y_max;
>+	int x_max, y_max;
> 	struct focaltech_hw_state state;
> };
>
>@@ -126,14 +126,14 @@ static void focaltech_report_state(struct psmouse *psmouse)
> 		input_mt_slot(dev, i);
> 		input_mt_report_slot_state(dev, MT_TOOL_FINGER, active);
> 		if (active) {
>-			unsigned int clamped_x, clamped_y;
>+			int clamped_x, clamped_y;
> 			/*
> 			 * The touchpad might report invalid data, so we clamp
> 			 * the resulting values so that we do not confuse
> 			 * userspace.
> 			 */
>-			clamped_x = clamp(finger->x, 0U, priv->x_max);
>-			clamped_y = clamp(finger->y, 0U, priv->y_max);
>+			clamped_x = clamp(finger->x, 0, priv->x_max);
>+			clamped_y = clamp(finger->y, 0, priv->y_max);
> 			input_report_abs(dev, ABS_MT_POSITION_X, clamped_x);
> 			input_report_abs(dev, ABS_MT_POSITION_Y,
> 					 priv->y_max - clamped_y);

If it's allowed and race-free to change finger->{x,y} in 
focaltech_report_state, then you might fix the Sashiko [High] issue on this 
patch by just doing:

finger->x = clamp(finger->x, 0, priv->x_max);
finger->y = clamp(finger->y, 0, priv->y_max);

not having the clamped_{x,y} variables at all, and updating the two 
input_report_abs lines below to use finger->{x,y}


The Sashiko [Critical] pre-existing issue is the same one fixed by my 
previous patch - thanks for applying that.

Richard.
