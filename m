Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794232882;
	b=M4zaf+EYkpi9uSUbSGkXDeQL3AmqE4g83xi9LE3lfthxAXgK71d6nTlnjCumGQ+DjWBI
	 hSUanh4Zs40GFI5fcEWWvYwwknn/RWYoPUAdr6ciPRXvjSVFmyQuFdfioB6OUI2MFOv8l
	 UmbKnCQW1GepFb1yge/0sLY7c8XOpPBHiWE2nPrUM68Ii5a5ILEGCtn8DgtxmE/2Ofl3I
	 MEduIm2KOnaPBfpO4Nn8J5XWbGqhIiXWTZo0jbx0AExe6eSbNIA8AMCFaOoCoSZmQvqlE
	 tn9ruNWiArtrvYtpObSiVgJ3zVdxQ8PtbdosGG9tSGOsns6K8/2F4cfrYkOHtcaPaGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794232882;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=Tmgm8xUQcaLR49MNM2baqIVEgl4eJ3Hns1s+z1HaD0o=;
	b=JRbfQy773hwYD1Jp+Y5A3XBLeaUNj5spzOYcTKclG/ovcRkPBGWETDaoNBdRAfdytzFs
	 gG2n9dRhj5o18BwjDINxnqGAOU2X2DWUKK/wIscQxUfBfa9vqtTBXYDvgCndpPk4TMsjf
	 f0g993hrnYmicJAcz1otqW1x1EiUutehg7vT0TzVoCgqVkW/GKW8GSQpkT8VeYEh3woWi
	 vTwOGLa4/43rLuRy9orcbC13NiZGqXG+eQPMynPutxQmiiGQElG+fmqoZm1dGXcWG6ObT
	 F7NA9UsDfv/y6PBZ0qTRhXBS0Se/qLO8PSA055XbXXecn8B15Ob/Qgd2FOQnvEIXfnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NOLHGCdI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86939606A31C;
	Mon,  9 Nov 2026 14:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NOLHGCdI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1856F1F0089F;
	Mon,  9 Nov 2026 14:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794232882;
	bh=Tmgm8xUQcaLR49MNM2baqIVEgl4eJ3Hns1s+z1HaD0o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=NOLHGCdIsWTkk5BQunH44FLyIxxSZHD1AngBQygT1zFXxy4ufgyOlrf72tABj0O2+
	 MbHHNV5AK04Em5I061q5jPJhWGx/hkV24I9ZO6N6YH9mRIjCu8RAC2XPt6Qp/IQ67W
	 SbIXBe8ltek1bLGBhvXqspVoRT41leK4Dkt3/FsX6SObs10HRIFEYZ7O6SPwLI8ksw
	 ovG362JVrUMy/DL8+IJUq/B0Ww4TPX8Z6p6Glfu8cUKaBb2a+dgkqA0AAKdGR98apT
	 zK4ewTScJaKfM1k7A5o7Mql6M+MCkH+kKOvEKVfZTBPqDVOGDWMeEyus89aN/DJPYJ
	 DY6ahpDrOpiEw==
Message-ID: <a66f889b-f827-4b4f-9d3d-abe4fc939780@kernel.org>
Date: Mon, 9 Nov 2026 15:01:19 +0100
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] HID: lg-g15: cancel LED work only after stopping the
 hardware
To: Torstein Eide <torsteine+linux@gmail.com>, Jiri Kosina
 <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: Maoyi Xie <maoyixie.tju@gmail.com>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261109094426.1432465-1-torsteine+linux@gmail.com>
 <20261109094426.1432465-5-torsteine+linux@gmail.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20261109094426.1432465-5-torsteine+linux@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9-Nov-26 10:44, Torstein Eide wrote:
> lg_g15_remove() cancels g15->work before calling hid_hw_stop(). In
> between, a backlight or game-mode key press makes raw_event call
> schedule_work() again. The work then runs after remove() has returned
> and devm has freed g15, which is a use-after-free in
> lg_g15_leds_changed_work().
> 
> Cancel the work after hid_hw_stop(), once no more raw events can arrive.

This is not necessary the hid-core avoids the raw_event callback getting
called during remove() by hid_device_remove() doing:

	down(&hdev->driver_input_lock);

before calling the drivers remove callback.

Regards,

Hans




> 
> Fixes: 7705b4140d18 ("HID: lg-g15: cancel pending work on remove to fix a use-after-free")
> Signed-off-by: Torstein Eide <torsteine+linux@gmail.com>
> Assisted-by: Claude:claude-opus-5-5
> ---
>  drivers/hid/hid-lg-g15.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/hid/hid-lg-g15.c b/drivers/hid/hid-lg-g15.c
> index 592c9747738e..a341b0aca249 100644
> --- a/drivers/hid/hid-lg-g15.c
> +++ b/drivers/hid/hid-lg-g15.c
> @@ -1927,18 +1927,19 @@ static void lg_g15_remove(struct hid_device *hdev)
>  
>  	g15 = hid_get_drvdata(hdev);
>  
> +	if (g15)
> +		lg_g15_unregister_fb(g15);
> +
> +	hid_hw_stop(hdev);
> +
>  	/*
>  	 * g15->work is only initialized for the models that schedule it
>  	 * (G15, G15 v2, G510). The G13 and Z-10 leave it zeroed, so only
> -	 * cancel it when it was set up.
> +	 * cancel it when it was set up. Cancel it after hid_hw_stop(), as
> +	 * until then raw_event can still schedule it again.
>  	 */
>  	if (g15 && g15->work.func)
>  		cancel_work_sync(&g15->work);
> -
> -	if (g15)
> -		lg_g15_unregister_fb(g15);
> -
> -	hid_hw_stop(hdev);
>  }
>  
>  /*

