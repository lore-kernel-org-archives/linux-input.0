Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794418059;
	b=cqiLNgOERc92yeZzx0485QezVqUmYplJMRQ7QiCNKYw7XKnKlqg34/x/SaYL3CkpvtaQ
	 scPpZywpzGarEqkDhDbk+vXYRakfCe40fkYJuRPApKVa5wNqKqhkoPXELAt4OJyshk1Us
	 Ai0FKH0Ayiv9hbe3L2tovzIqSjc/mYmXonT1Ii9IC48xlcvOoaQqwXZRphshvNsvb1Kzz
	 bSqUuNdVvh9uZkxY0EFCHcriHGsuh4AO4GcYiiIeAw8KNNAp2Wf6QZM/VjtyNfMx3I4IO
	 5Iboq+QLWADewMXuAvpesxGnZHNim0s3u8sZxseW5z+mWu0Ix1426dN7pQUKdBCHVfg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794418059;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=dSXiAG+3ZY/F8hDcAaOCi5cr+p+IP1IyyF8LUmknS0o=;
	b=e5+VIEMwaGEn2gV10KeMlhtkhCZCuAo5ibWRL3UDWLu+RbcZZqDP/hCTIR1nwc2HSojZ
	 zNCdbTlMAzSXg9lqVawciRlp9U2bQHyhzIzyQurQ/h5Dg3bK+rw3MUYfrz8kr0F67eTnr
	 EzjtD4fE09mlIp3uq8PL5qvTCm1DwBzG9QdxrlHwLfwQHE/nVYwKYIS6kee33l+0OHBC3
	 fcPr/3/QNxlB326J/GFfBLbjUj4enZ60K10GaRa2oImLKr238DAJhLDDstNb+JtGVYHMG
	 s08doqPr0gC/Firg9zUjTytttF92ex2gjOoshQBEnXokXbzLhEY0TlI7bTDGgyHAWpg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tyg6ByNt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF1F606A31C
	for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 17:27:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FF1F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tyg6ByNt
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1ae58d17cd9so2656442c88.1
        for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 09:27:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794418058; cv=none;
        d=google.com; s=arc-20260327;
        b=bidOh4Nuz0M7qQ+KVAfx/D06lidasM1S2XBeHNp0mxmu/7mnErlr6R2G1p4JK2wKpE
         4dWJQLdOyb70k7K49yCCmzGVMRqO2Oyfxjs0D4GZKh9QZ3SOKoVaKUjg2OSioBb+Ottp
         8Fz3zNp217gHnG4eBZ6YtWFw7AarYTCLv0NULJQINgxKVc2bD5jZq9fzyWd/wzytqTMF
         8qaPPFu5JC6asRhiGfE80PvFtGyYp7Q++7Q0GT02EWBW8/BbDPgys30aXannPZfjICYl
         mcKwMH6+RgGoPOBiOdskpMvht+z42J6/riMcY9Pi856jbW+Lb/a1gG5AcavzDmgmMwA9
         ZD2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=dSXiAG+3ZY/F8hDcAaOCi5cr+p+IP1IyyF8LUmknS0o=;
        fh=keQI7VtI239bwXYbYK6WfpCMLX13qdiwGKTCYlaw44I=;
        b=XX3vpoUX64IQFI7itfxHnHNB3doY/rUf3F5WIwb5vyqpSmedE8mILQcOh5K1/F51K0
         xpuhBN2iIMqupzsJOftiCQMW1VbogDGI/JmDDxhLU17ClaKmizKXLhK1ub4EaIzmQynW
         c9x0KiAAx5Z5wb0ajmPhbnBGYv1Dn9ig0CS4ylXy0Wwje4vcerdviDAqdw+nFDs32Vn9
         6wMPQm8+b+8+euuP4xhi2piL+XE6/I6SH08q5U7sPfqtlRUJQQktUrGsVTQ3lnv7PBl9
         Y7vflAKjuh9hGOfBOL+jdGT8n/77iZH5T+9MUBu9NWevq/QnmERZLt61/QMQooujok+O
         JZIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794418058; x=1795022858; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dSXiAG+3ZY/F8hDcAaOCi5cr+p+IP1IyyF8LUmknS0o=;
        b=tyg6ByNtCOXd3UYgLHVPAI1+s7aXekSUxLSTJbM32FAWHq0F0hWB9djyJgasJd1l42
         DlZT03LRvimmYFbcXJ8OpaFRa3cx9q7UJbKhuAk/Jm0SAYEDJjv06ajoRLw+qQhw8HQn
         aSSpBhMTEtSVeGhM/EzuCVcS1Lm7G3woe7vAqtu+G27MtEGOkFLxNCajtXnJ653o51PW
         fzjCMY73D9UmZgsWxWWoQRSCKRhEmuBciPAGjPkJzhJrqxS/TmBsBBGf1WcU1zqkDRdQ
         WsWzelklgQGD824LA+SPXKwXpOlwzYv0i/NYwkLd4KbbE5axg3lQ7t+Q0S26/Ho8kO/H
         uDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794418058; x=1795022858;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dSXiAG+3ZY/F8hDcAaOCi5cr+p+IP1IyyF8LUmknS0o=;
        b=24U6CDJKUNctCRNQXz02dmJ36MrCj/b2d+3mDrW0If9iHNJDfEKUIQ+XHihTBM5hSi
         dFoIx2CSOH51anJgXn8HpKJj+de8VdQ2YpCea/WybShMauWaO6LYv+++ICsOJ9I+U1u7
         Q2IQGd7NFDCNHGg2kTgGHHizA9FfxE5J4+m+bHXSu1/pm5fvlPXpIw2Mu9epexY3ubDh
         HXnbbvE/++aVkXlPGYu08n/7TpMbB/GVhXKB4AVLQL8CHMYLey7UW5Ixhsxf0UvX1h3o
         sOwVcUeIwn+B1+2G2scPQWBQBoGEFYEyvaGEIVlmmOvO7fqjMy4pHljvvQ1nALt/Vj6G
         +aQA==
X-Forwarded-Encrypted: i=1; AL+hErH6gfOs1tNUtrUZk+vVi5rduk9DoVzUmGsSkRJ78I0J9b/OxAqJqeymKFQ7vubrOBw8/rtFybU5B4bApQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+9va5511l27427QwfC6iCo+IOBOFTwolSt4PthPzPd5BeNZ9pH
	anycUMLmp5Yi07pRVMaTPG0f+NullQeJI+dB7028i4mMhFuGD1rJKF0ebok8hbh1CzCmEj/Q8t3
	nzt8udtPjrUOM5KZPi4fpWEV81PM3Veg=
X-Gm-Gg: AYBFou0z82wNJqP3TsnGfChUlZO+KcdzyusPx/VajM+hFtcK1ZWw/NXQha7JkdBhma4
	jh75uE/nAOn4CG7W25BTg87ZlPjvTZTZohrQd6DJdC18/snYe3NhVTUOPlYRmKhx/wpz+W1G2K6
	IIuKCscwBMjGwnf+vmqARk3DGjGfot/6rFfjXk8BJU96ZOhOBcWvueGJ4Gi+8L2cSKKsW5O2AhD
	wc54ErtEmRK27uShJSUk80RM4U9JFG3tAFGxyiqYnDYnUI93UI5zs4MT1NIoOkLVFvb/Z2neLng
	KIzayKguNSFqniBrZrCXL8OVSD42w1isdhSlnbHHlToEOCmDDkhmQuCuT7uwPnLHnApnT8ReBIm
	nThMx1HK/edEu+G0hrtb/W+wqhn+AtnZVcK7Q
X-Received: by 2002:a05:701b:4558:10b0:1ac:f84d:4036 with SMTP id
 a92af1059eb24-1b3c02f34fdmr2668936c88.9.1794418058188; Wed, 11 Nov 2026
 09:27:38 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109-legion-lighting-rfc-v1-0-a87e1db8c5e3@gmail.com>
 <71ecff766a91670d509b1286efd995b71efc21f4.camel@rong.moe> <CAPKD0HduW_atYsz47Nv-9A_88K1B33xENUnZgQAKcH4VHqV9PA@mail.gmail.com>
 <db41708e7676697fda99573a31d7747dee112403.camel@rong.moe>
In-Reply-To: <db41708e7676697fda99573a31d7747dee112403.camel@rong.moe>
From: Ciro Pedrini <ciro.pedrini@gmail.com>
Date: Wed, 11 Nov 2026 14:27:26 -0300
X-Gm-Features: AclHuK-k_YZiigppKf1NhmY5lI_KumHaoapWssTv6Uvn4FXhXg28fO9lUyYHPbk
Message-ID: <CAPKD0Hdt7WNC5n47Bpug=DMsJ8m63UnGprm+-cLaUh3tb=4vCg@mail.gmail.com>
Subject: Re: [PATCH RFC 0/2] Keyboard lighting for the Lenovo Legion Pro 7 Gen 10
To: Rong Zhang <i@rong.moe>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Ike Panhc <ikepanhc@gmail.com>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Werner Sembach <wse@tuxedocomputers.com>, Aaron Erhardt <aer@tuxedocomputers.com>, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hey Rong,

On Wed, 2026-11-11 at 20:10 +0800, Rong Zhang wrote:
> What if (four permutations):
>
> - c197 sends 07 AA 02 00 00/01 00
> - c193 sends autonomous_mode=on/off
>
> And what if the sequence is reversed (another four permutations)?

I tried all eight. Before each one the LEDs were back to the
controller's effect (AA 01, autonomous on). "host" below means
autonomous off plus all lamps set to green.

  c197 first:   AA 00, host  -> green
                AA 00, auto  -> controller's effect
                AA 01, host  -> controller's effect
                AA 01, auto  -> controller's effect

  c193 first:   host, AA 00  -> green
                auto, AA 00  -> controller's effect
                host, AA 01  -> controller's effect
                auto, AA 01  -> controller's effect

So the order doesn't matter. The LampArray only shows with AA 00 and
autonomous off. c193 keeps the colours it gets while AA is 01, and they
show up as soon as AA 00 is sent, without sending them again. AA 01
takes the LEDs back even when c193 is not in autonomous mode.

> My implementation connects the LampArray application to hid-input, so any
> HID driver with hid_hw_start(HID_CONNECT_DEFAULT) or
> hid_hw_start(HID_CONNECT_HIDINPUT | ...) will initialize the LampArray
> application. Therefore, I suppose the only thing we need is a simple glue
> driver[1] for c193.

[...]

> Does that make sense to you?

Yes, it makes sense to me.

> I will CC you when I submit it. For now let's focus on the driver for
> c197 first.

Thanks, I'll test it here when it's out.

Ciro
