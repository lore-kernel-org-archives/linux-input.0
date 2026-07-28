Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71153A83B1
	for <linux-input@vger.kernel.org>; Tue, 28 Jul 2026 22:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785276101; cv=none; b=cl4Hxj21uBskO6h2wV9/wmURVfiaSs2Qb81phxqFyK7o95Bh5phZ2YvH+ineNz1iYO0L5GvfvwBcqhCaZku7OBgJs8MTujCWkBaQvxt1VJIq/w3efWTHSekg3P0piCCrlgoVnyLJ4fxhgd41n8oBk9/JappWTa7rM5btP9bF2zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785276101; c=relaxed/simple;
	bh=0CH4KMcXr9oaeZD6NlFB8ot6AsfL7GrO+pmLK0gGiww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sWCrc/yUQRtv7DTubklnArAo3f7sKchI+Zi+jOej9UbxwkiP2UN+hyBEXWhUzA0Un2ULo90+ceeq8pBajEgJGA2Hcyb8FRp5wlK1iKs0eCTgV9pP79m6RImpeo0m1R6KzDKUCOkdtqULbiRv1Z71OgCk9gSTPasVdpyhWoX/yxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fXmEs9RV; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXmEs9RV"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-92e5c92c389so23639185a.3
        for <linux-input@vger.kernel.org>; Tue, 28 Jul 2026 15:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785276094; x=1785880894; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nDoun7OEr0VFdjpcVSQJxT0IbQ+nFZ9G6YKg1Q7PLrM=;
        b=fXmEs9RV91CLtFbAdYh7UvysjaRhmfATSMR/BBQL4tHd892tp5nALKAHMsgahDh6HP
         KS9IWCyBYN2O1VpfazulCP8fBl7Tzb8O+NccxJdCEHpq2/da00FsKDc9DT+ztrxtBSdC
         1UKMtKFHOs/xzb+dzmobbadd7NLYo+/qKpR8ASd+BjfUPbJF3bxYhfgedy5Egb54IiNu
         ozAtI0+K6XSITpFcr9pM40BlnWIOaNKz9oPH4GUES0r7mbwsc80Q03sKlz7dr2OvtJuB
         LqMfcRjRqv2T1849dDeXQO+2CuK16HzfW3GyuTbR50Lqp48WfkTQ5NPYjWkL67KUOlL/
         +uBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785276094; x=1785880894;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nDoun7OEr0VFdjpcVSQJxT0IbQ+nFZ9G6YKg1Q7PLrM=;
        b=NGDE+8EP1ulXlLKBnAU/BLa75pBQju0QNexqQdP94gHV07TLknl/eLierR6v4FqMld
         lS2vSF1N2if99WM7V37JKLcShcR8sBuqptjB8g8BCFOdFgF9jkphU42yYZC0uO63KkDX
         KC0XKJdAZT1w4tvaujUBzcT8Ds9AGPxiyO8WiVU/VG61LEobEkib2NfTIYWFdZsTJmmz
         Md/2wkcOqi6JU97vrrC5aFKAEDH2UGjzvMGKRyc8bZOf741OkLgsZtPec5GK+Qlxmv3W
         tED5xQnhicV/cd2ciDYkKKwPo30Dgkrl/MFfNJkBDAh7/bZ4TOqwUE9uOP+hhFXD7IDU
         MbFw==
X-Forwarded-Encrypted: i=1; AHgh+RpkRoO6HYTo80AccLZKzFM63xLXkmmx+suGZ35hCskPbSSKIFDvCkSveUJ7M682C/CXfVO6xL8En20pyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIArVpblOvMEYwRTdnhg8rQ04BaR1BtvEYefQef+JYqy7gMCES
	bk2xv99nIdxUJpD3tjW3T6nB2CVADiOEDkxVCU5xFtSlGeSPaxuw8JoV
X-Gm-Gg: AR+sD13sCrgxh7YUiuKUcAeGEprkBAju41iED0h7cGMIa9gYPqzBqaCuvMXEM0s7Sc3
	2OXm8ySSGyDPu3bcI5tVuctB40KJhNpxndgYz5wjjSTvccF3L/vixw0rpbeVUADWj8BfqIR3YhT
	Ru/PceJ9zK2GE+UjqUZZXY6bP7SZs+8N487YAlloUJG7tG8aJNeyizipVPsEkC5xByU8zR+gWc7
	9oNwKSO/5kGrz4Q+nwaoIJS6kyMyvRO8riRRj0bJDMfM8Kv2MiDBbTtSsfJXE8g7qTj4hLkq9Om
	fn8Is2S+BSZKJDW1ai9DUfznepu32FxiZ5AtdEq3HLq17/5TkeRop2H7eOz4va9jS0gls09ekyg
	USFA3m6VDUsgX/TVYly4inSO971I0PsKvuyVAKR/9RBkH+orPmEMA1e7LZBc5x9k0gO/cZzXjE4
	rmz1SNhTgyTXnC2PR9FLR3JVp3UEIpO0wanbUT9uXeMN1q3cl7r0cf8jN+EJmQQAB4isYT
X-Received: by 2002:a05:620a:2787:b0:915:7e22:6f1f with SMTP id af79cd13be357-933026c884cmr440344985a.22.1785276093731;
        Tue, 28 Jul 2026 15:01:33 -0700 (PDT)
Received: from [192.168.0.78] (pool-100-11-178-145.phlapa.fios.verizon.net. [100.11.178.145])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-933e7361dc2sm28717185a.43.2026.07.28.15.01.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2026 15:01:33 -0700 (PDT)
Message-ID: <cb66c1e4-25c8-46c3-9330-188c9e6665f8@gmail.com>
Date: Tue, 28 Jul 2026 18:01:32 -0400
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 0/2] Lenovo Yoga Book 9 keyboard dock detection
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, hdegoede@redhat.com, W_Armin@gmx.de,
 jikos@kernel.org, linux-input@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20260722201659.874469-1-carvsdriver@gmail.com>
 <10e5c25d-7fc8-5db8-e8d3-b76c5d413acd@linux.intel.com>
Content-Language: en-US
From: Dave Carey <carvsdriver@gmail.com>
In-Reply-To: <10e5c25d-7fc8-5db8-e8d3-b76c5d413acd@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Got it.  Thanks again for your patience.

Putting together, hopefully the final version for this patch and 
re-submitting.

Cheers!
-Dave

On 7/24/26 7:42 AM, Ilpo Järvinen wrote:
> On Wed, 22 Jul 2026, Dave Carey wrote:
>
>> Changes in v14 (addressing Ilpo Järvinen's v13 review of patch 2/2):
>>
>>    - Restore #include <linux/compiler_attributes.h> and <linux/spinlock.h>,
>>      which were accidentally absent from v13.
>>    - Restore spinlock_t lock in struct yb9_kbdock_data, spin_lock_init(),
>>      and spin_lock/spin_unlock around input_report_switch + input_sync
>>      in yb9_kbdock_report().
>>    - Restore pointer-out yb9_kbdock_query(d, u32 *bkbd) and removal of
>>      zero-initializer from struct wmi_buffer out.
>>    - Restore int return from yb9_kbdock_sync() and error propagation in
>>      yb9_kbdock_resume() and yb9_kbdock_block_probe().
> Hi,
>
> Unfortunately, this still seems to miss one non-cosmetic change (diff of
> diffs, v12 vs v14):
>
> diff --git a/drivers/platform/x86/lenovo/yb9-kbdock.c b/drivers/platform/x86/lenovo/yb9>
>   new file mode 100644
> -index 0000000..0000000
> +index 0000000..40a2566
>   --- /dev/null
>   +++ b/drivers/platform/x86/lenovo/yb9-kbdock.c
> -@@ -0,0 +1,322 @@
> +@@ -0,0 +1,324 @@
>   +// SPDX-License-Identifier: GPL-2.0-or-later
>   +/*
>   + * Lenovo Yoga Book 9 keyboard-dock detection
> @@ -421,8 +449,10 @@
>   +      /*
>   +       * _WED(0xEB) returns EC.BKBD directly as a 32-bit integer
>   +       * (LENOVO_BTKBD_EVENT WmiDataId(1) uint32 Status).
> -+       * Short-buffer guard is handled by .min_event_size below.
>   +       */
> ++      if (!data || data->length < sizeof(__le32))
> ++              return;
> ++
>   +      u32 bkbd = le32_to_cpu(*(const __le32 *)data->data);
>   +
>   +      blocking_notifier_call_chain(&yb9_kbdock_chain_head, bkbd, NULL);
> @@ -441,7 +471,6 @@
>   +      .id_table       = yb9_kbdock_event_id_table,
>   +      .no_singleton   = true,
>   +      .notify_new     = yb9_kbdock_notify_new,
> -+      .min_event_size = sizeof(__le32),
>   +};
>   +
>   +/* ------------------------------------------------------------------
>
>
>> Changes in v13:
> [...snip...]
>
>> Changes in v10 (addressing Armin Wolf's v9 review of patch 2/2):
> [...snip...]
>
>>    - yb9_kbdock_notify_new(): drop manual length check; use
>>      .min_event_size = sizeof(__le32) in struct wmi_driver instead
>>
>> Patch 1/2 (lenovo-ymc) is unchanged from v9.
>
> ...And there's no need to apologize. :-)
>
>
> I personally keep earlier versions of the patches I've sent myself around
> as files so I can easily do diff-of-diffs against the previous version. It
> has saved me sooo many time from making fool of myself.
>
> I actually normally write the patch version history bullets based on that
> diff so I won't forget anything important from it. Nor hallucinate some
> changes that I thought I'd made but didn't (=> back to the drawing board).
>
>
> If you need the old version you can probably get them from lore archive if
> you don't have them around anymore (but by not placing them cleanly into
> own threads one needs to be careful to get the right ones).
>
