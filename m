Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306133264CD
	for <linux-input@vger.kernel.org>; Wed,  4 Mar 2026 05:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772601393; cv=none; b=KQJpDSmHJewcPIFEm0+81Rory0gXV9GVufhoO1OCFFQlciLst7DUHJ+Mjg5hMWKZF4vCUB3sNSP0DR//1fEi7Huk2dLt1U+W2tQJcZ6PgE9vyI1LMovyOLP7+YsfGjTZ/g4bFG4JCmc4YV9EirDbbQ1oOGJNHxki/voDtI2mgU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772601393; c=relaxed/simple;
	bh=LlrUhB0S+OU221K17IyqbMQCsIe+vEPFaX6v5N4QKXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A8Ldo2FzFoZNPwBRUGKfSsByZEemwg2hr3fIIdt3BCD775fhcmwY4jcj9I/5cib8TvBfcXrbew8c2LDjcvDtwF6BrJahMGjX1BOOkjK6fY3mKtac++baskQSiRkR090tXIun43KzPOUeazkB7VAuMItvZO8X5+datN24Ex/Hd/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T50PrEAN; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T50PrEAN"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2be26842fd5so550638eec.1
        for <linux-input@vger.kernel.org>; Tue, 03 Mar 2026 21:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772601391; x=1773206191; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O37kV+n0p9DPxLWK1dkzZtLnWm1CJUdw8A+nfqpMtQY=;
        b=T50PrEANM801aTmGBo4+DQ+HPbgqIWMUr6LXEwRtyfbOQHIKyX3JzuOyWcJHqzuSxc
         K1nJd758FEhMhLyMCtpkVgCmdC9oP7ydvKm1UjGk2bTA9jmJxLUVx5TpDnnyfkGCu8BX
         /QvGqzVr4WmYypotV20hzckdANJ9uwf4DgnbLwVBHM1vGRNGKc9q8i/642ENH+Z7+FWV
         mgbyS9mMEYbCC4M5X6yZMynZls7GVPgIFay7b/6/9Q59PyejQ7an5gey+OdXbULWMKnm
         VSXA2M0L04G4SjxM6aPkc+x4a/WTIe3lUUp+lLVybF2jNSY1IOeCK5Rh29v+zur8j/hj
         51JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772601391; x=1773206191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O37kV+n0p9DPxLWK1dkzZtLnWm1CJUdw8A+nfqpMtQY=;
        b=KY9NJUYd7SgF7opJFd2U96f8ypBkpdEr9d/Y2a2LK6KJxXyUDlY8fuNPoU1A2atkmz
         0vmFjQpnd0p3qX15zuHj0VzuqeLwZhgc1bBs5Q601wSHprTVls2RmhvR0rf0kv2YjxLc
         A8/1zxYFF4JQGw3Itg9O6fLtVkH2TSjxdFD4Cwd3n9Q73HO02IyV+5f24wJZRvUKWya8
         3oRl35tLlZMduniR+5AkM4kdtwFrRozZmr/EpZs5eSRB66xsYGw9BS6kEZIMcPhsU5La
         Th/30U/qhqkcduSGU4RL11bjqL2CfrZECk1nf09CG8eK56PkMq6RRzYojhqjicoVf8wV
         /IUQ==
X-Gm-Message-State: AOJu0YwTDg8R8thHhcpeGiuxw1sAf72vQTUU2jkaCzcV5aBxp5G5KODB
	BePCbU3aYbnsf4RukaT8zrHSP/OC62fjMZ3GzlAx/a4XdHQofQPR2RpEmZ3pww==
X-Gm-Gg: ATEYQzwdnrLaJtmuMexpWBuCJke2lfpjgUJNbgTMMpa0Ji9zR52oxQjHpiW0aGcwexC
	lDbL4NGCrqmNwNf2U/7a+7LjyecRId9NI4DKERWqQeCSE0oOmayl6o0gk2Hs9VY6DCyry8FUMAX
	GZpxu6hdqIRaERQ/HlSm9xAygljShj3fSR8nvBPXHXUcleRGJWKOSlCtRHFR7mEO/fZUNhoIpYa
	CDIKZdog7gZeO2ac7diSHTyP5DqFBR23t4RLfNzS8Sh5gQupVFD1P8n14a4ByyeJO9SPCdxpyoB
	W/XA2EUQzpTb/VL4CbVur+ZY4URrTgLA6kK1q4LxTV0jTgGxLhvt1pPhy/WiPAUL/6H8yjOvsX9
	X23+3aFLVWXxcldyEZaE7WXx97jrz8kUZREcoAi1474kKJmf2zuvsWOx1vNw6akoqa7MDv22OPB
	7WU9Og8vU7zh7/ISPv05sV/Zn2SrWbLNNTBEr0djRM1YrEtjbDstJFGs+MuGKgxzDp
X-Received: by 2002:a05:7301:1297:b0:2ba:749f:81a7 with SMTP id 5a478bee46e88-2be239ec667mr1568271eec.21.1772601391239;
        Tue, 03 Mar 2026 21:16:31 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:a048:d9ec:d217:7d59])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be249ed6a4sm2402827eec.11.2026.03.03.21.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 21:16:30 -0800 (PST)
Date: Tue, 3 Mar 2026 21:16:28 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Ngon <ngon36201@gmail.com>
Cc: linux-input@vger.kernel.org
Subject: Re: [BUG] HP Pavilion x360: Built-in Keyboard and Touchpad disabled
 permanently after screen removal (Stuck in Tablet Mode)
Message-ID: <aae9BCEaeeUfwQof@google.com>
References: <CAF2ktaUNWWED4g+wqa0OuFbXSaVV7Lt-9Kw3co9KE+PYswNW=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF2ktaUNWWED4g+wqa0OuFbXSaVV7Lt-9Kw3co9KE+PYswNW=A@mail.gmail.com>

Hi,

On Tue, Mar 03, 2026 at 03:32:42AM +0700, Ngon wrote:
> Hi Dmitry and Linux-Input developers,
> 
>   I am reporting a hardware state issue on the HP Pavilion x360
> Convertible 14-cd0xxx that causes the built-in keyboard and
>   touchpad to become completely non-functional under Linux.
> 
> 
>   The Situation:
>   I have physically removed the original laptop screen (using the
> device as a headless mini-PC). Because the lid/hall sensors and
>   rotation sensors are located in the screen assembly, the Embedded
> Controller (EC) or BIOS seems to default to a permanent
>   "Tablet Mode" or "Lid Closed" state.

So based on the above I can not see how this is classified as a "BUG".
You modified the hardware to the state it is was not designed to operate
in, so it should not be a surprise that some things are not working.

> 
> 
>   Observations:
>    1. Running libinput debug-events clearly shows:
>      event20 SWITCH_TOGGLE switch tablet-mode state 1
>    2. The keyboard (AT Raw Set 2) and touchpad (SynPS/2 Synaptics) are
> detected by the kernel but do not emit any events
>       (verified via libinput debug-events).
>    3. On Windows, the keyboard still works despite driver warnings,
> likely due to a proprietary HP override.
>    4. On Linux, common kernel parameters like i8042.nopnp,
> i8042.dumbkbd, or button.lid_init_state=open do not restore
>       functionality. Blacklisting intel_vbtn and hp_wmi also does not
> force the system back to "Laptop Mode."

With blacklisted intel_vbtn and hp_wmi do you still see an event device
reporting the tablet mode switch?

> 
> 
>   Question:
>   Is there a way to implement a kernel quirk to force-ignore the
> Tablet Mode switch for this specific model, or a way to bypass
>   the EC's hard-lock on the i8042 bus when sensors are missing?

Do you see anything from i8042 in dmesg after you do

	echo 1 > /sys/module/i8042/parameters/debug

If not then you'll need help from folks at HP to see if there is a
EC command re-enabling keyboard and mouse.

Thanks.

-- 
Dmitry
