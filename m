Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE6C3921D0;
	Sun, 14 Jun 2026 11:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781437453; cv=none; b=cQTY042KmxZtolJSv5S5ccawTLEJ2/ohEpd0fL3lx6tVOIOBTuBhCuGAlkM9nbspuORVWP55HErPWYNvSTyS/UCz2MHk3KYe+bWLFBAJqZMdLXPM8DmmAppwWmSNYRS10rGV5qPmO8MgRdYFMwOi/Hi6hQsJyjpMUQZNSLHi/cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781437453; c=relaxed/simple;
	bh=f9867WjDBLThP/Xx9SvxCXselsU1MuCQ9++DGnHuc6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e62MZygA1IvIW2TwWZw9wX5TIjhYz6XFMsqWi9BLdNPENNmsgcE8C2HNuY7TSdlavFPE1EC4PR2BGPnQQsmdqIrkhBu+ZGVVaPysOeExDgjse/NjqTvG6HcDo0pWh8RunriPekDAOz00YajEc7S6tEkM9oShOQTJmB2BipBqwLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I6GqcIGz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I6GqcIGz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D792A1F000E9;
	Sun, 14 Jun 2026 11:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781437450;
	bh=bPD3KlULZenBXERKqqV5u+da9HN5BLNGsSq62i/BQmU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=I6GqcIGzJR13Gr4unNRNIYFctFr4AVYPivl/aFhLmUDhceSjFnXToS6Q7uNwatApj
	 TWX168hxiCyFk+NWkDEy6YyH1zET0ZTiiEUqbfQy6yj/mGH5fWi8hcDVDCj+mtlgl4
	 r243+EIMGpoChxrEokl8eZfOCIOsm7sCynfTCYTPtVv04gySCmdUnw90Gusd5hp0hq
	 WnWuddDwQN8gm7sQQd9IPCZIs5GLS9r4VOJJBWpXjE4xzuRhSHq8EDjj3Gbn1l5aIn
	 Z10k0E6rrWotu+UdnyjAllCxdUrNIumdgewSNIAVMsaPDPPlkZ9xMN+M9ThHSjj7eS
	 C2P3EqZvZBbEA==
Message-ID: <6f529998-2b4f-441e-88be-fbc4eb33461c@kernel.org>
Date: Sun, 14 Jun 2026 13:44:07 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Input: goodix - clamp the device-reported contact count
To: hexlabsecurity@proton.me, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260612-b4-disp-6844625d-v1-1-df0aed080c9d@proton.me>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20260612-b4-disp-6844625d-v1-1-df0aed080c9d@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 13-Jun-26 04:10, Bryam Vargas via B4 Relay wrote:
> From: Bryam Vargas <hexlabsecurity@proton.me>
> 
> goodix_ts_read_input_report() copies the number of touch points reported
> by the device into an on-stack buffer
> 
> 	u8 point_data[2 + GOODIX_MAX_CONTACT_SIZE * GOODIX_MAX_CONTACTS];
> 
> which is sized for at most GOODIX_MAX_CONTACTS (10) contacts. The only
> runtime check bounds the per-interrupt count against ts->max_touch_num,
> but that value is taken verbatim from a 4-bit field of the device
> configuration block and is never clamped:
> 
> 	ts->max_touch_num = ts->config[MAX_CONTACTS_LOC] & 0x0f;
> 
> The nibble can be 0..15, so a malfunctioning, malicious or counterfeit
> controller (or an attacker tampering with the I2C bus) can advertise up
> to 15 contacts. goodix_ts_read_input_report() then accepts a touch_num
> of up to 15 and the second goodix_i2c_read() writes
> ts->contact_size * (touch_num - 1) bytes past the one-contact header into
> point_data - up to 30 bytes (45 with the 9-byte report format) beyond the
> 92-byte buffer: a stack out-of-bounds write.
> 
> Clamp max_touch_num to GOODIX_MAX_CONTACTS, the number of contacts
> point_data[] is sized for, when reading it from the configuration.
> 
> Fixes: a7ac7c95d468 ("Input: goodix - use max touch number from device config")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

Regards,

Hans


> ---
>  drivers/input/touchscreen/goodix.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
> index f8798d11ec03..17fcfe45988c 100644
> --- a/drivers/input/touchscreen/goodix.c
> +++ b/drivers/input/touchscreen/goodix.c
> @@ -1057,7 +1057,8 @@ static void goodix_read_config(struct goodix_ts_data *ts)
>  	}
>  
>  	ts->int_trigger_type = ts->config[TRIGGER_LOC] & 0x03;
> -	ts->max_touch_num = ts->config[MAX_CONTACTS_LOC] & 0x0f;
> +	ts->max_touch_num = min(ts->config[MAX_CONTACTS_LOC] & 0x0f,
> +				GOODIX_MAX_CONTACTS);
>  
>  	x_max = get_unaligned_le16(&ts->config[RESOLUTION_LOC]);
>  	y_max = get_unaligned_le16(&ts->config[RESOLUTION_LOC + 2]);
> 
> ---
> base-commit: 8e65320d91cdc3b241d4b94855c88459b91abf66
> change-id: 20260612-b4-disp-6844625d-463f81173dc6
> 
> Best regards,

