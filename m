Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793830651;
	b=resJwKt1HfUET5bjJDzwc6xDrIGCU4LKrNsTDmy3U0rRVU5NcOhcm9fHlezzizFe73oy
	 WZcimaUwax9x5PdKZO4eHvyyot5vK0WRE1AUGHckZpcjZW82v9l5jNssFJk3ILWV/YEQk
	 OhmmkTqjLgNQ1IHTSBPA3OwqCfcvlsKj5e+vaeREm8T4rICzDTIwbA5FfRkNIYWeZOMMa
	 mEiu4SEKKRBDRVei6/5qVPBmeWwawOxHmarQSmfKjjvbEjkCdgHYrmAI/V9oIQeY/JsR7
	 afIk/hAFrt/JANE3FvoXNDIGWF2MwaygwAWR9/Vp1FaPm2mEX6LHkessA04jTevuIag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793830651;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:Message-ID:From:
	 To:Cc:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Content-Disposition;
	bh=Zn+s7F7I4KDGF4WBy1BDYJ2NJqBDI7huyN28B8tAPuA=;
	b=HL+0uxzQVyLAdbMRdiv+Mq/ZqZ3fD+IjSwHNhHd+25AxU3lKToKHK7nZysA+bIyIpH/k
	 WpY0RTJ5X1z5q8AoX87wyD3Eyzl/o3/jtCBqm8irX7DDPkaS1xbHLpiq6YGC+F0HegZEq
	 3Xy3eQloC5zg2ai0fcEPUrtQWY1IUQfdvsvNtm1+IMV86unsUxX1Zjq81Yq7DWtArQU9k
	 n05MvPQgRkXPBMOBSG4Em0AGbnSTaJVF6gubtOrfFl5otbjY3PMQVd93fC7JFyKDyaGP9
	 gXRek7sfPr3svys8Rsdda5gVxEKiUV8ycnMLb6ttJAi5oi6bPg4xFarVm8QxiOioZnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rq7jVyiI;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E47606B2DD
	for <linux-input@vger.kernel.org>; Wed,  4 Nov 2026 22:17:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87E47606B2DD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rq7jVyiI
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-170135e43c7so1930908c88.0
        for <linux-input@vger.kernel.org>; Wed, 04 Nov 2026 14:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793830651; x=1794435451; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Zn+s7F7I4KDGF4WBy1BDYJ2NJqBDI7huyN28B8tAPuA=;
        b=rq7jVyiId5SSUWkNa+M8D63+z01CkI/0k/D5EN9jk6cghq65qdlCLjewI2YbHL8eVD
         TNSO1KguB2DBlQ99L4533C8P1Qbxi4dp+nDvx3kcsJqs9CHQOVjbf49hEVEuSIMYQMdY
         NznZjBiUfe8xrRU0NhCLFFPZSezS+s4/NWU8wLuN6ouU35FirwT4Yb+/+NCCNzWSiAT3
         ci9CvZb/hyyqoPMTWmxN6oN1cW9U3istGyfuqV0q03m0k6rzPGys7BaVTnRpJHmlO5nQ
         P03bfVHN7CZjy9X1fO6JeQk8FSW2D7KbedN0VluV1jWjS2muSMqlSe8zPofBn1GZPQBO
         WZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793830651; x=1794435451;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Zn+s7F7I4KDGF4WBy1BDYJ2NJqBDI7huyN28B8tAPuA=;
        b=wKO1GloDshJoDITnnSI2eApZ7i2nU5uXguNNaIwAbb1dyboEqoNw1OOk9BqxAfrcyd
         Gho+G3unr3bgZdp6rUw+6jiC2SQwTQY7WZObvhH+XS+tLC1IPYLy4b4EkYtl3ppwKSQF
         imaJNo5FHecLkI3abLl3Hfd/3mOCmKeVV7lZhs/PwQPAh+G+G9VgUabIyLI6s8eAVFw4
         PaQpSK1Cp+wA3P1HS/DZYw8idt488BSFvGurTMomynyCYNK2w5Voq03z7j3Y8y3FBdqZ
         L56CjxxM5H2O612N6JP4/OuhtiM4/MnYUSXuRWr5NIiZ7YiJRiHaKqLS0MEKhkRITTJ1
         h+fg==
X-Gm-Message-State: APuU4Z/REq28rQGG5PpcVuCrem3JwEels+k5G63V9is1hjGAouXqWaUg
	ZtXSLyQHMhG8N2rZQ5YkF7o6v/XzCSxCtj3XAPN2jcrJjZm1w5YHuZea
X-Gm-Gg: AYBFou1W5ugEgFbfKbG4akSQeY737iCMl4K/3PYxRCEKBGOxexjJz46DqLoKBvpOsDb
	oENewsiH3Ood/I5qtFat9IyEsI+Qoo/KKReM6djA2EEM6nIaysSVTibReg9NyWG/tt0jS9Bg4H1
	4pT5oEe9GNmB2rw9EhWEe3o60FcNNQco0ulCBnDBD9OqaoCaB6PeVVIoiaICAHsZgFgQACCf1VJ
	Qw3iul7G0iSLQkh5b/1Ks58eXmAjHoHOMckeMZubNEEIoxaR6YVg20YJuhu27X5meQBV1VJnUmJ
	M7qJIuVEORy61rKiFkFENjSBugACSaIRTsMwwp+a4atdIBW+b475PCtIEGrwi5uJXHjG8hMeXAE
	QKGSpllTjjiALoHJub+x9ut0FuXVx0B2HxQnkO+BIxJG4XQjF8IXKKO2XWLqsd6TJgbC/UQtw6j
	dIZ6hbH68dVpxCP0THrkh02zbLhbr3QD+7iVm3iw9fuu2eTEr2Zm08i7HLFUiuX7VkfvhpvjKoG
	pBBHhITv7aLoLkV13UMy2U1Y489JIvDttFbZgblpdOeCZmyVDtkHLMkKMZtiVa3GbeoI9Hcw4OT
	Pb2CRq/OqRS2m64OB9/ZPZrMSymxSpfwwr9VNcyPq4qd7czDTn6Fegiv4Pabw1YPk24k5mrA/Nh
	01RMhIgAe8ZyGCWA=
X-Received: by 2002:a05:7022:5f0b:b0:195:5b0a:7abf with SMTP id a92af1059eb24-1ac5bbb4cefmr23854642c88.7.1793830650490;
        Wed, 04 Nov 2026 14:17:30 -0800 (PST)
Received: from localhost ([2a00:79e0:2ebe:8:c8f4:b7d9:252f:4483])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c463e9sm10646970c88.14.2026.11.04.14.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 14:17:29 -0800 (PST)
Date: Wed, 04 Nov 2026 14:17:28 -0800
Message-ID: <a27ddee4a4404e7d607b09f92924b2b7@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Guanglei Zhu <zhugl3@xiaopeng.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liuc63@xiaopeng.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] Input: adi - bound the two-stream packet merge
In-Reply-To: <20261103111714.472080-1-zhugl3@xiaopeng.com>
References: <20261103084135.426629-3-zhugl3@xiaopeng.com> <20261103111714.472080-1-zhugl3@xiaopeng.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Guanglei,

On Tue, Nov 03, 2026 at 07:17:14PM +0800, Guanglei Zhu wrote:
> When a second device shares the wire, adi_move_bits() appends the
> second packet to the first one at an offset taken from the
> 10-bit length field of the ID packet:
>
> 	for (i = 1; i <= adi[1].ret; i++)
> 		adi[0].data[((length - 1) >> 1) + i + 1] = adi[1].data[i];
>
> 	adi[0].ret += adi[1].ret;
>
> Nothing compares the merged packet against the size of the buffer:
> adi[0].data is the last member of struct adi, and struct adi_port
> holds two of them back to back, so an oversized length field makes
> the loop write over the second struct adi - its device pointer, its
> length and its packet - and the inflated ret later walks the reads
> past the buffer as well. The connect path also calls
> adi_move_bits() before the length has been validated at all.
>
> Reject a merge that does not fit in the buffer. Use >= for the
> combined length so adi_get_bits() can never walk to data[ret] with
> ret == ADI_MAX_LENGTH, and invalidate both half-streams on the
> rejection so the unmerged packets are not decoded as standalone
> reads.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
> ---
> v2: per review, use >= so a combined ret of ADI_MAX_LENGTH is rejected
>     as well (adi_get_bits() allows idx == ret, and data[idx] with
>     idx == ADI_MAX_LENGTH reads one byte past the array), and set
>     adi[0].ret = adi[1].ret = -1 on the rejection path so the
>     unmerged half-streams are not decoded as standalone packets.
>
>  drivers/input/joystick/adi.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/input/joystick/adi.c b/drivers/input/joystick/adi.c
> index e07b719..41262b7 100644
> --- a/drivers/input/joystick/adi.c
> +++ b/drivers/input/joystick/adi.c
> @@ -168,6 +168,11 @@ static void adi_move_bits(struct adi_port *port, int length)
>  
>  	if (adi[0].ret <= 0 || adi[1].ret <= 0) return;
>  	if (adi[0].data[0] & 0x20 || ~adi[1].data[0] & 0x20) return;
> +	if (adi[0].ret + adi[1].ret >= ADI_MAX_LENGTH ||
> +	    ((length - 1) >> 1) + adi[1].ret + 1 >= ADI_MAX_LENGTH) {
> +		adi[0].ret = adi[1].ret = -1;
> +		return;
> +	}
>  
>  	for (i = 1; i <= adi[1].ret; i++)
>  		adi[0].data[((length - 1) >> 1) + i + 1] = adi[1].data[i];

In adi_move_bits(), length can also be 0 (either from the 10-bit header
in adi_connect() or when port->adi[0].length is 0 in adi_read()), so
please reject length <= 0 as well. It would also be cleaner to compute
the start offset (for example, offset = ((length - 1) >> 1) + 1) once
and use offset + adi[1].ret and offset + i in both the bounds check and
the copy loop.

Since you are hardening this driver against malformed packets on the
gameport wire, there are a few more bounds issues in the same file worth
addressing:

In adi_read_packet(), the condition adi[i].ret < ADI_MAX_LENGTH is off
by one because adi[i].data[++adi[i].ret] pre-increments ret, allowing a
write to adi[i].data[ADI_MAX_LENGTH] when ret is ADI_MAX_LENGTH - 1. It
should check adi[i].ret < ADI_MAX_LENGTH - 1.

In adi_id_decode(), when ADI_FLAG_10BIT is set, adi->axes10 =
adi->axes8 - i can underflow if i > adi->axes8, and for ADI_ID_TPD and
ADI_ID_WGP, adi->buttons -= 4 can underflow if adi->buttons < 4. Please
also switch the non-string byte fields and buffers in struct adi (such
as id, buttons, axes10, axes8, hats, and data) from char/unsigned char
to u8 (and s8 for pad) so their signedness does not vary across
architectures. Finally, the decoded axis, hat, and button counts are
not checked against the sizes of the static adi_abs[] and adi_key[]
tables for the device ID before adi_init_input(), adi_init_center(),
and adi_decode() walk adi->abs and adi->key.

Could you please fold these fixes in (or split them into a small series
if you prefer)?

Thanks.

-- 
Dmitry
