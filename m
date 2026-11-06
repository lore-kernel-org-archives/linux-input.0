Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793946078;
	b=lvzcc5nw+UHcoeFDecAPId6RpNdNWK3LPV08XLl2+bQ6uLrQd+SJy7b9NnFqHDvPRd+s
	 5CSN0nQi81T4Xs5ggfAlr6SYgn/ZThJXtz4q2Jh/Cc5fxm+i61sLxp6M+9399NiQg6dIP
	 WNK+DT6LBC4jBN63HErHem4pMiqs9533Or9g4gqGl+ay2Jn6N4EQYtuB75QG9Rzl45YuT
	 Fi1pAU9LCtioqNis1/ktLFofSalaeRNidvemEcoWPKizz63YO4qOD3XMCfcxDfFGrHpgL
	 lA+VBl6nkyKf5PpLU82qLfmQXtdDLUI10OKKS9g20Xy+XE/1e9GUCKsHzhpd5txekSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793946078;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=YvrHetLWEaprA/YnNV90q7vlMXrIcclPCKoaaWze1Ho=;
	b=UM3bu0G+kMrwSZppB8gRyRACixLqIDx87izxu6zNAQokyCnPcQrBX5M1smPHjA3CGuFn
	 WsJ2NyKzFbSEjypQ8j+rJl9ltBInB6N8b3huq6+gkD4P39DHIrFyWK7CJ7+VBrRt6Oyix
	 SazCwpJ5ooR5/7OcjixS+GFJ5EQFYcon7M6pr4hNoUrKVtaIFrCjifcWH45n8bJOtzqRD
	 pQIhNndpBpMPRkLI6qkVH9TE5PxMupl//yHDXY3jBUZkMMLhlf7brRiqD4WfLadj8yOL3
	 Qm8U2Ho+WDLW5g7E8trcZzkKGzKR4//Y6DPK6s4NrH3ynZqRMv8x1u/8UlhwWCO6qtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ztXfG5sF;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE2D606A32E
	for <linux-input@vger.kernel.org>; Fri,  6 Nov 2026 06:21:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FE2D606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ztXfG5sF
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-15dd124bbe7so733255c88.1
        for <linux-input@vger.kernel.org>; Thu, 05 Nov 2026 22:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793946077; x=1794550877; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YvrHetLWEaprA/YnNV90q7vlMXrIcclPCKoaaWze1Ho=;
        b=ztXfG5sFYa1gDCb5MK7O5ODxZx8Ot7aqD6aVXhfrBu1YthxQeyeDTOngXQIekaFBk2
         ud2CFY8feYyphEMjTtSfr5ChFcnFoKwKgJOJ9IoHUMUu5y+fD4XMihHQPZARom98ADxw
         zof0ZO5DASe8RYakHHC0FZ99P7i8m23AzoMze8ud9Vc0QIt+kn3ovw/5/C0fovLF0BzX
         PWvrTGTy3oX+hw5ty9SNeDqCsElSTc80bTsnvR5gmjbCfYHPOKkrLBzQe4wh/3ThKtNr
         qd6oDnC6A1XwFDS5/i/eo5CZLm/rM8ORB3ZPnpnl7UbIEEgHhAqUb1rRy66BlXXkxbSZ
         BhBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793946077; x=1794550877;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YvrHetLWEaprA/YnNV90q7vlMXrIcclPCKoaaWze1Ho=;
        b=Mu1N4cAoRu76RV1CI++iqJeZIcUwegaPx24CHA0VVrt8MeOcncsU9ks7dDwSHlQ+dW
         Lx8DQ4hGiy3gT2LZtvAQcrsOMK6yTeWJlbmIFEAbMWdv0sF0bbfJXJ5ipcSDn6F1hPWM
         Odz9bkjoYLpKaNjU0Nedt+Recr5lWGkjbsnmDVBxMs4f1SMw0z+yb9u8I6lKbtVNPJ2x
         CytWvZbw40PT3uuWfoAJ3FTzTUc/yKCPs2jK5SP7PdcJZcIKMqjcJlRHlOnulsc9RVAm
         dhwY92oAOHU+y4OoPDXG+R/snN/59OBisQ0VWlRgj6SbTXy9Rv5IuXR+Trgh96dg/SO1
         PWwA==
X-Forwarded-Encrypted: i=1; AKwUvBwgFL53ih+Lq3E7DwUjTfuVjeH7yAAY17My4slHk2zywSdl19T1o3n1i07iazVfsA+IOmiTDouPVPHt8w==@vger.kernel.org
X-Gm-Message-State: APuU4Z9rajT5NICrltjFgi57oeTXb4z55fazFU65xeOIABcBx8RoFbx2
	audd92xXA0jWg0rlkfsdiBye+P3hqu5ikU4mwXcZ3tN4Q5QaVFUIsylh
X-Gm-Gg: AYBFou1rDeEfr4uzoiYoQ0I/cuckrv9sDplpyX9bKlAu0HM3bzdihLee7kuPmWDl4Cn
	5uMNQjieCondMA7OExe6SnHkaPylvPnCTGQTQLRmx+eaPp8lYPFhy+7ATZHktTIX3NaagLU6Ztg
	K3mHret9Zk5/y2qhRYVZzlBah3RejnRF4AmsXYBIojxm7QzOb2SQnFVAwyLMZlaeskj5NlhZgnB
	M5s2ir0rHnOtKJVd26g80VaFYaUJVcZuYAkREtW1IYVhJ+yn/4zQoFPEror80WvtckPKpelNh63
	JefkQ3YzJIzF2Zj+NUTVLArp4AcTPjqvdBCPs3m0Kb7WYU1iFT+rbwlcWTmSB4GPIYZLQxomVXa
	mt1RrGdFximVLGFVw+0RAyGWxiPAVPAoK4nI/bMq5Bfkr9lYkml/+ecuHWVB896YfdLyLmtUoUA
	jW6lxGnp2dBan7kMD7XQ3NF8AMG/b0UOUHlSDMKkCp+eBMn+fz36ns5Guv3T3j/j6jzcDVXPMPl
	cshzdnARrWkNd9LLAvzB2u+XoXAnbfwf+gkLHn2GdAgTT4vDNxdVVLM6bTeUj9KwOAVH+QVt4g5
	yMD1KbKeMAyZCVZpEzQVBdNQ5y5ZTvywaym2gGtqWctM+7eTW6egfWqBDIzjCZbVXvu5
X-Received: by 2002:a05:7022:1582:b0:19b:1202:77f8 with SMTP id a92af1059eb24-1b25d3497e3mr2346370c88.32.1793946077182;
        Thu, 05 Nov 2026 22:21:17 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:64e:8358:c9cb:c17b])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e4df114sm2890595c88.18.2026.11.05.22.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 22:21:16 -0800 (PST)
Date: Thu, 5 Nov 2026 22:21:13 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Guo Zihao <guozh23@xiaopeng.com>
Cc: Markus Armbruster <armbru@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2] Input: xen-kbdfront - bound the backend-supplied
 keycode
Message-ID: <au1xwKh4LVxHyUMW@google.com>
References: <20261106014957.4130059-1-guozh23@xiaopeng.com>
 <20261106020217.48481-1-guozh23@xiaopeng.com>
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
Content-Disposition: inline
In-Reply-To: <20261106020217.48481-1-guozh23@xiaopeng.com>

On Fri, Nov 06, 2026 at 10:02:17AM +0800, Guo Zihao wrote:
> Keycodes arrive from the shared ring the backend writes:
> 
> 	if (test_bit(key->keycode, info->ptr->keybit)) {
> 		dev = info->ptr;
> 	} else if (test_bit(key->keycode, info->kbd->keybit)) {
> 		...
> 	} else {
> 		pr_warn("unhandled keycode 0x%x\n", key->keycode);
> 		return;
> 	}
> 
> The keycode is a plain u32 from the ring page, while the keybit
> bitmaps it is tested against are sized for the KEY_CNT keycode bits
> declared to the input core. A backend that sends a keycode at or
> above KEY_CNT makes test_bit() read past the bitmap to decide which
> device gets the event, and no keycode at or above KEY_MAX is a valid
> EV_KEY code in the first place.
> 
> Since the event sits in memory the backend keeps writing access to,
> the keycode must also be fetched exactly once: re-reading key->keycode
> after the bounds check would let a concurrent backend write feed an
> unchecked value to test_bit() and input_event(). Snapshot the keycode
> into a local variable with READ_ONCE() before validating it, and use
> the snapshot (as well as the already snapshotted pressed value)
> throughout.
> 
> Ignore keycodes the bitmaps cannot hold.
> 
> Fixes: 4ee36dc08e5c ("xen pvfb: Para-virtual framebuffer, keyboard and pointer driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guo Zihao <guozh23@xiaopeng.com>

Please explain your threat model.

Thanks.

-- 
Dmitry
