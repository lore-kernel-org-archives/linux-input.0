Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5F236AB5A
	for <linux-input@vger.kernel.org>; Sun, 26 Jul 2026 11:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785067060; cv=pass; b=NZIDRlmRY19LLuSqyoFx7XZWLMxOixBSJlzGDI2G9ptqe6prkhGt7za4Lfd9mqtBW8EH4AiPLN7ozCm3Qcb2/FRFM69M65j+rXo8Bj+XUhWHUCajpEWfeGbuMIRGrz6lJaNtbYby5M/OrKUPKP854cF1R19LjX3/Km0k1LnnUd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785067060; c=relaxed/simple;
	bh=C48qQbePcuw3sQu6QI1vTw1fXCVHZubspNmxvNeDGDY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dsav3w3c31E5DMk57AubHw1BL0do0d+F7Z7XF/LJSPATTDX110h8ILMcWUuyuqKE539W57JqPQAgrvXpV5cIkRNshuzYbkgEHUy7uyTQT+bv+D6TvaaMjEBOQF0+kwtvc534H5R/D4KKnUZ/cKfaXupHBZUIVrRwDnSvcmA4JL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rDvSTT2y; arc=pass smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rDvSTT2y"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6aaea785032so870826eaf.2
        for <linux-input@vger.kernel.org>; Sun, 26 Jul 2026 04:57:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785067058; cv=none;
        d=google.com; s=arc-20260327;
        b=MVecCVnmm5pansTtV24q6wwQwcHL54Jxozfu5B7gk2XFVLs0Uh/i9mhgx4z0DCv0ld
         kkD9QHyr1g6VdDSabnyKH63DMjmPSwGZHMqAyBvC3xa5zPnNLiF1asszIenjOaNf9y/O
         00Tx5oqeOrIsVdr0chpvtVqYBzTQr+Ji5qUPDVH4vCWO3HWZXZXDO5l7CXOe3YtGA/oT
         r7CyCTYqE03FLJTRux31XozBokWDkoUJMYiNEPDFIF6NJmpouCwTj0snimCsc16vkXNT
         XJgPGYNFbUiRAunj25/hCVsYQ/Q2AdmfyE2j5H1ifC0TLWtFRpvrzpBxRFPrO6jyVIfU
         9yWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=C48qQbePcuw3sQu6QI1vTw1fXCVHZubspNmxvNeDGDY=;
        fh=AABPhU+K/4Ynuz1T/Uo57eqlDbc9RFgdNFqIu5iESQg=;
        b=H7vz3u+Iato0jy8LOXKr6hmW6osZ580N16mJ//4zBQdE42qpTWMPVzkTkYwXH6pBTc
         izFJSeIxMhfXAz50kQTH+VulgxUq23JsJIH7t2Neh+FnWLJcWuUFh7KUK3brwZmfnS/e
         XYf3m/HWC7gF5vn3QCBh422ZTOSfJ2fjcAvTQDZ2w5DUCKmw3KNBSAcPoBQp7B1YudWZ
         CBkRf86msokJmlNpmn0ksvIHeSv1ZvwsADOpcfldCMbbi7fp0mk/slKQfNcVY0wVd6wV
         VuWpjK8YKkYr7dajwt3mKGxBxiusLJf5CfySfY6vwwbmQqSHMup5lvSgeCu9SsDjlQyl
         84bw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785067058; x=1785671858; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C48qQbePcuw3sQu6QI1vTw1fXCVHZubspNmxvNeDGDY=;
        b=rDvSTT2yeRWqkxBJd0XMH0pm2xv3Jymtayb4IbRvDZMVQjfAICQIn4nSEoPpUv4s31
         KDDTyJ/e6xKD548Bkmve0adj5BXLnd0G72nLnKZNsUtxrbrOkYZXIqkfNClJ9SVbFNqP
         3aS928Qi4XqSjHF+F/Xk1yfklidMOHSxsBZLd7NMwDZdRkyh8KCwr3gDbbKti8iVq/MH
         oKQBCwT+YxYm1NAoZqZND2KS3oJI6ILTGnm4/9Laq0KAVjDf6W44v2+mvS+ua/hZHNnk
         vk3Vi7BEDI3ffUkvvJFK+CV9ZTKu0TElPFShf6fsD7KY95Ku2iAGPdVbUdnbUTaCdDKg
         Mz2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785067058; x=1785671858;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=C48qQbePcuw3sQu6QI1vTw1fXCVHZubspNmxvNeDGDY=;
        b=W51/BMBe8R1sdXms7lJzBvuJYR8EZE7DyUOhOVqYniwJYnql54k0yaF08f7H4e2hLE
         9gkd7yNTCMW1gEb/XMJYJgP5NWWdo8BCJkw039CbB4deGaWczgWxTkSYYRfc0Zx7voHJ
         m72aTMqsdfK0pbYvylzPe33N+vjCsD2Lk9OglHz8VBSbDHNKZm6HrJlX0GOmB5sYjTUM
         D1cudW4FYnyHDSFmZhHiC9vm3MzqFy5F+P/mNkdnC28+95bvtOnUiO23VkB30emfOKvq
         gV6hgu8oSbpStXp0FXMqZW9f2nbrS6oTS8OuDYNhNbVOjF2s0aDVN6F78HaCtigQY6PP
         +xqQ==
X-Gm-Message-State: AOJu0YyLF1u5vPiRTxIYT0CXgXcctU570yC03iH5tNBisqH9Ju9lAxzb
	p1MZLa1i0yPtUdkEawHLjAaLb/Dl1Kk02lQux+UNITZERwpr0jPl6Lpnbg9plvYlVlNR9mdv2ek
	KCAeAARlx6Pkk1/h1L7TKKU677a+HPFc=
X-Gm-Gg: AR+sD10TPPxKUqGVtf3LridwW+7Bochn2ITWRJ/5aeEcHyAweFcP9w/VMd9gFC43tS2
	3RdJzWHejLWGwal72SpTWq811JiScQcZjS2HbYBujS9d2+61B5DQERZQdjgXgOLJKrlWec8jezE
	CTscg/h8HJZ0R3J3VV+/e6a67pnsqGfJIn68a2X3AfZoI9LBLQe/OUsF1yfQxaAbFHpYSo+UHln
	kQ/kip7Nvu5Hv+jCAWEuSR9770vL4pFKeQZqULJ7wWazSQjRINkD1eogwbj/Q==
X-Received: by 2002:a05:6820:162a:b0:6aa:ed3a:7950 with SMTP id
 006d021491bc7-6aaffcd8e59mr3713938eaf.63.1785067057496; Sun, 26 Jul 2026
 04:57:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f03a892c-0961-4e07-a6e1-dbc3ff2064db@gmail.com>
 <93177ed2-10ca-40a0-9efc-95d83913e59b@gmail.com> <amWPu_sGMCFJLN5E@google.com>
In-Reply-To: <amWPu_sGMCFJLN5E@google.com>
From: Zhan Liang <liangzhan5dev@gmail.com>
Date: Sun, 26 Jul 2026 19:57:27 +0800
X-Gm-Features: AUfX_mzyJWM2M0GDu15gCmekxQGQK1fXd1riPLyIJEsgr39ZEEJ3Il_NumYdgYo
Message-ID: <CACyTbM8kU53ZwjAA=2U8oBFd+uX3MGWyr-=cB9sSha521Uq3LA@mail.gmail.com>
Subject: Re: [PATCH v2] Input: tca8418_keypad - fix potential infinite loop
 and OOB access on invalid keycodes
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Dmitry,
v3 was sent here:
https://lore.kernel.org/linux-input/20260726112658.37D911F00A3A@smtp.kernel.org/T/#t
It broke the thread because I forgot --in-reply-to. Sorry for the noise.
