Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793015310;
	b=iBlBs4cFFxW8MGe5+vOfFR+SE9gQDsfe3G06latn3bi/2WxMsqYb/l20NAXlUMVtoJKS
	 yUmyCXPO3inrsV6ovr1DJnOro1Kl9gTIsEMVVZ1ALom6TFuL6zSnRq0dusbuvgr+yFiqQ
	 c57FyNmuPINay023Y3FSg7nzz+QrnHI/cBt+kXOUW+GycHF9E8OtuSUOHTxpk6+ISeuwr
	 57yHAZnMlbGyFvvoIoLlA2wYYL03yJviR8i55Vdzgx+mFVp8Es67xrSoJyyprYrDjxkqc
	 h4vXxUHlWWWVnSeHU5vbAaU9va0O2rfuWpxv9BQwXef1h29hRbIvBLNZZ48Eiw+gcTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793015310;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=8VwqPR7o/pIdUz5IDnlKbeGGBhSmMQN6xR1k/yCPgMc=;
	b=4+sVxttfcfU0uorOuEGvzinShih+cpzlry5vsTjS0ethe04hWkIcCk0RPSerW87onIx0
	 uph73ufRQLhLeihh5rzRA5Qm+CF+vJcd7fz4QQ0vFmroLRCm0xuichBRp4y2IsU86dOjd
	 yycAO4MQvnW9gEMCzIgQefAmTmqhf05XAJmrvvKRhj3lyedMZZMpw9DKgF+X896x3npkt
	 Q3GYCSFS+Noy/UZqjT0o2Y9bywde8wUHI29kUXMybbq05zy8J1WQr+bNv3NDhhaHRUTHa
	 t2qpBcDbcKtid8tLfBhbGTh3B8xzjbA7jRE+886Q0QF7ewjUf1oVxbH5aVH1N+fC3DA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TweK6ymc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55D8606A31A;
	Mon, 26 Oct 2026 11:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TweK6ymc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C9961F01825;
	Mon, 26 Oct 2026 11:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793015310;
	bh=8VwqPR7o/pIdUz5IDnlKbeGGBhSmMQN6xR1k/yCPgMc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=TweK6ymcW0yP+juYkqnQinqOuF2Hn80Nd479g49VgpqRQNr2yi/hIzuHotusf3o2y
	 C9XApIg0V7CyvIfYfmXd8G1Crll6U9ngsxk9gOXLSIw1TLGv2nys9TtP1OeH7ZFEcP
	 QgWiHo/WJfollYGrwAH3A4SGlCGNhxIkvwMLF74IKc6RIuSOCWki8q3Own3ZxmgqRT
	 +0QarU8ImpVYVRg4q1jqgd2UVfxxQ+1KIt2KR70ukrI7VCEBNDBZ3eubGwHzg6Cb60
	 pcrBskM13RCZtS8h35Rl0im1Pux3O/ebmyDJ0UPIYHreDYVrnIaCjGQ1ec4JMenTEO
	 zyWMKtXb0etwA==
Message-ID: <c4bd90f8-cdc3-4812-8e36-e438b17c048a@kernel.org>
Date: Mon, 26 Oct 2026 12:48:26 +0100
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
Subject: Re: [PATCH 7/8] platform/x86: x86-android-tablets: use 4-argument
 i2c_smbus_read_block_data()
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Mika Westerberg <westeri@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
 Corey Minyard <corey@minyard.net>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Sebastian Reichel <sre@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
 openipmi-developer@lists.sourceforge.net,
 platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
References: <20261024-i2c-smbus-read-block-data-v1-0-19bb97467982@gmail.com>
 <20261024-i2c-smbus-read-block-data-v1-7-19bb97467982@gmail.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20261024-i2c-smbus-read-block-data-v1-7-19bb97467982@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi

On 25-Oct-26 3:48 AM, Dmitry Torokhov wrote:
> Pass the expected response length and destination buffer directly to
> i2c_smbus_read_block_data() in atla10_ec_cmd() instead of copying
> through an intermediate buffer.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

Regards,

Hans



> ---
>  drivers/platform/x86/x86-android-tablets/vexia_atla10_ec.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/x86-android-tablets/vexia_atla10_ec.c b/drivers/platform/x86/x86-android-tablets/vexia_atla10_ec.c
> index 67dba9aa51f6..bbfa040cd4ec 100644
> --- a/drivers/platform/x86/x86-android-tablets/vexia_atla10_ec.c
> +++ b/drivers/platform/x86/x86-android-tablets/vexia_atla10_ec.c
> @@ -65,16 +65,14 @@ struct atla10_ec_data {
>  static int atla10_ec_cmd(struct atla10_ec_data *data, u8 cmd, u8 len, u8 *values)
>  {
>  	struct device *dev = &data->client->dev;
> -	u8 buf[I2C_SMBUS_BLOCK_MAX];
>  	int ret;
>  
> -	ret = i2c_smbus_read_block_data(data->client, cmd, buf);
> +	ret = i2c_smbus_read_block_data(data->client, cmd, len, values);
>  	if (ret != len) {
>  		dev_err(dev, "I2C command 0x%02x error: %d\n", cmd, ret);
>  		return -EIO;
>  	}
>  
> -	memcpy(values, buf, len);
>  	return 0;
>  }
>  
> 

