Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251283019CD
	for <linux-input@vger.kernel.org>; Sun, 11 Oct 2026 18:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791742381; cv=pass; b=OYMSxuUhKbcnp+JII6TkGRbuknkErklTNrJTXjnoQFtkzX7kQJrzA9tUFUbUnNvY9bi5BQlOyFjoIbF8QLx8utUbIkKvXbgbRsNTNObQuuJ3fqOcG9WlTQWmdJyAaIWis2/AR1wQgUlrUx0NAt3/hIgx+G4v+Sgc74OjItharoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791742381; c=relaxed/simple;
	bh=gwRi8tJ5LauvJF15FnsWPOaMsiBcZj8ycmgZAY2TY4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bGoDLT+HoPQjssL6G+xGQ9vcHl5CRS5v+177iyKyd3oDz+kghDaxUbGkLLWqveIdx3bnz9DgPEBqB0sLY+IKySnjUu4avpsqItNkbD9CATBDzX+jrIiDSoL9U0Y6QKmJ2M/I4lj7ITd0Xun/B5oMJiOtpeog0Pcvl2g3F/jFPUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cg5b/B48; arc=pass smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cg5b/B48"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-33c2520ad38so2756474eec.1
        for <linux-input@vger.kernel.org>; Sun, 11 Oct 2026 11:12:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791742379; cv=none;
        d=google.com; s=arc-20260327;
        b=gtNG35UcZyM+CnH4ZVaZQj4imk0soDZN12xKZJ4AEqOysm2h2FmHC3sPYDvyo9Qozp
         DSZzSBsJdyW4SkHfEO0qJOGzKL9Eng80WUGuaGOO8U9jQ5neTZ5I+dngY+4kHkmOC7mG
         pARahlvWpcUtLffyeIfdJMX9ZedhSOYk78LTV9lXlg++9Fdg5R5zTrBC6iQPg53c+um0
         BaTPviHO/Ycv18uOrPCj7tI5Q8odPVKSdUUi7569yIooSNbuQPUGWBzQQ7wWfHBJlQkn
         v8LbtDdusryieWOYBJt0paRRIhEjcQSEe5ZKF0Cwu/INRLcy4B+XFnhKMg+96/4npxNL
         1yZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gwRi8tJ5LauvJF15FnsWPOaMsiBcZj8ycmgZAY2TY4w=;
        fh=a5+m8SSY9vQcXufU3UbZd4R59CMCX3YEHw1gUWy2fh0=;
        b=ci1zFOocToKSYGZaK2+mXehDproy9gfq3UU+8ccRlQGqWTXj4eKz9Tt4nYIA4zlC7M
         NcklcTQIsjAlKw+W/d7I8TKKfv8SoyMuo0lY67Drj/QmPp5qWchfQa6PLhYoc/MwAeCr
         k5+SllExUOE3CXmpiLckZkTSG4d/FyMhEihVRQCCvXva7D8bic1TS0az377zRrLw2P77
         0Hqjy49sWpR1JABI3PgbzGgO3BiaWjIS4uxcbZoAlGAV+q5hiamIAcDlvdAMPF4HM30Z
         MuG9xcOj9xSHY++BH/23wngSdZ14OD7TWtOCSZLVPxnJXaNzQSLhPQcJEwmDo/YavOmh
         eXhQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791742379; x=1792347179; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gwRi8tJ5LauvJF15FnsWPOaMsiBcZj8ycmgZAY2TY4w=;
        b=cg5b/B482OUEHIyUOiMGEfhIDYnFdmVLCPuk//Gb3hEnVfAtI5lW2XuvLOm3Vwhv5m
         d/MDzRmudHFTDKKYN9/yOE8XXbezepP8Qjh2IafESYzqBggmxnwe8frz+7904OG4/JiV
         p67s9nc+7t0kvH/hr+mPodwvuVpMuZcs8vYNmrVx/6XM1ASMjrvL0KgJsf5Hc3E8+adB
         r97eUPqeTOZWJ4V0sT7zMpLtS+iOozgMrjebqajOpmkUQN3xxgbmR0JxnMclTXpVTCo2
         HYYgSxjmrqyf0fMRpwhZL+0h+bIwdg9lzSZ2zwPArwo4D5nccqO5nXSm0Buzg8ZpsjVZ
         tRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791742379; x=1792347179;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gwRi8tJ5LauvJF15FnsWPOaMsiBcZj8ycmgZAY2TY4w=;
        b=1jCUPx9e1LslG3qFV0Xg7CQzvTtjr03siFmA1oVTBVzqDFU1kmX7+xYffX/YKU6R73
         RPeJPgBy7CUE9NYqKi51VNHszJCjJngviL/tXLMLeiwZjH+yYAxej3o1qBA6RIZ0QKI6
         gQYD+kVpUMJHaKvg77KGgFBV54miOp238hIUQNE5l96STj3vkZ7NK+OGAOmsjkRnrXRp
         KVtkfnynx/2gBqKB1P7sBWhMSdF0VsbvKNGDt8vYzeuUTjKUnq0tHj68jf6osanSOSVB
         +/Y1f2UDwkqxhb/DfByo9bWOHbqBelEZYGQqRmJRs0rcpA8fQEKo/9fmLtHkCua+L/3z
         ZHDg==
X-Gm-Message-State: AFq9FYJ4lWD5q0NW/9oHamarJXSbh/MU5Rxa00FLbTXBlY0ST+zGOXG3
	9wzvIb41v+stCn1kcIFK06J7GEIB71nrLB5LCZvw77lfxo6YnGaKh9zxJo2AjPnS9ejZnU5NdVW
	WCA+bgQaxeZnRQnXaK44U3zlyoc3ctQY=
X-Gm-Gg: AYBFou0+PLaTreEQ4XcVBQ1bRhwh4d6kMPdfYPPgGnievqmd4hYFXqSrS7I2ithxJU6
	oeFXOWYc/fU53WjJyXCR+m/6iSCEaEbZtFn0K3CrrhTNWlZkTScxtcYPjQIvprDI0tPWMoxtOK6
	Wnx1IbbxWeY7+Hw13am6t2Ujn2kC2AUBb16kzYgYsWjrXhccWoXW3ayVt3AAtxWjw2ec8oAJkbg
	arbz3E6GcKkxps2TlX/B397slEXdT/dnQGd3gVsP64bdQf9Ga5Zbu36tnOmCqSH5GRQCQgZf+vM
	EotDl6GjpYfff5erwzhSJ3U+q963kkls4zL38mLj55vfdFTRXjcTK1ywuXhcLXK9+htVencd1j8
	DW7EUxjvJVB2Rug==
X-Received: by 2002:a05:693c:62c5:b0:353:7d40:6636 with SMTP id
 5a478bee46e88-3537dedaae9mr9900985eec.1.1791742378990; Sun, 11 Oct 2026
 11:12:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <asmCc1VxVPLIMgY6@google.com>
In-Reply-To: <asmCc1VxVPLIMgY6@google.com>
From: Christian Lamparter <chunkeey@gmail.com>
Date: Sun, 11 Oct 2026 20:12:47 +0200
X-Gm-Features: AclHuK8acOi8aVEUTuLTHFRamALp4FOSGaLarP7QqSjuV8P0SghSz45EXW4MkW0
Message-ID: <CAAd0S9A6zNJU=BkUgpGtdHBgkcnQ0NyOWb46aDnBuGCf0TKvmA@mail.gmail.com>
Subject: Re: [PATCH] Input: reject parent overrides on managed input devices
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	linux-wireless <linux-wireless@vger.kernel.org>, Johannes Berg <johannes@sipsolutions.net>, 
	Jeff Johnson <jjohnson@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 10, 2026 at 5:54=E2=80=AFAM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> When an input device is allocated with devm_input_allocate_device(), the
> owner struct device is set as dev->dev.parent and holds the
> devm_input_device_release resource. Later, input_register_device()
> attaches the devm_input_device_unregister resource to dev->dev.parent.

Ok, why would this be a problem? If something other than the devres
garbage collection
callback access the data after it was unregistered... what else is
supposed to happen
other than a crash.

for what's worth: this patch seems to be a "spite" response to this:
https://lore.kernel.org/linux-wireless/20261008-carl9170-reverts-v2-0-3ecb1=
2089797@gmail.com/

I think someone else is working on a separate fix:
https://lwn.net/Articles/1038523/: "Revocable references for transient devi=
ces"
With todays Patch-Series V14 on: https://lkml.org/lkml/2026/10/11/475

From what I can tell, this should have been what devres was trying to solve=
.

Cheers,
Christian
