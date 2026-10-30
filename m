Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793347107;
	b=HWqfUUxkKFxYb9zPkPvOGhDiOA35xqzqWWRa9mKxZrI577SV5rqXPAc2fqXB0jmVe0hb
	 ssW8M+24lDHeKEjOeOxET//LlvbmFdfFpRPFafGqDio/sA2saAJHYPaebJ8q/tXZ0Mm8w
	 y8JgdZTmDTyMPzUdyJy+5eq81pVmXUfrIiIa3mI8rE0ao/cZQdCiBiCRAiY639yCgNK0m
	 pRSH+5Vo9tpQw8XpHLox0EyBMe2tp4qVdXqorjXED/QLoX7OSATuwuA5w2dl21ZkQlAex
	 iH/TdVyCeu8caDt++YI4gX3jPeLH/lsr1yqw1aetLWbGYfDnJUzzNLD2LEuIm0QfuBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793347107;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=4oAI5pxrIzXlsyWd5vlHzyNWwBTG6cTZg/AYjzhaORc=;
	b=310rQneRHHNlBgzC43FKQafk/ehl0fTE2d3vVXz+/R6FLuSBQgco1LzMyy8F6R7msoM/
	 NQWBHyD6L5+7dkPI2j9FRV+coVBmgKrGANcX+zGLM/c8abim8q6UDxjlymriRIzxXU5fi
	 mpEHcxvne9eP0s1pGXffISdaifMBJlJEg9cE3aHswT3xcAJtDm2Y1cuOQq9wz7uqrvRoz
	 AmD/WT804k/vkldP4RJ+SwnuH5/5OWaqkDLe6SDZ6KMU5bMCwZHf6PZHEFgCgVN8ptwed
	 4tUJY0A2IO5XUM7QxWY796nzHg7mxwS40vw2ZhEJh5RMcqQIM5cieABM0paCqtwlyYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GGG9vEBq;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5991B606A31C
	for <linux-input@vger.kernel.org>; Fri, 30 Oct 2026 07:58:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5991B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GGG9vEBq
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-170135e43c7so584136c88.0
        for <linux-input@vger.kernel.org>; Fri, 30 Oct 2026 00:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793347106; x=1793951906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4oAI5pxrIzXlsyWd5vlHzyNWwBTG6cTZg/AYjzhaORc=;
        b=GGG9vEBqs0KOdgWpmiKWSIt5WiVXa1uTTSIYJDfkXZTot6gliH6IsN1uuFr/2jrYSe
         U7gllHE3EA+ogniCMpvqYCrZN9iykitU4bK2wKXp4ARtTJbW4ms7vkhdADyORj/ycI4H
         G3KACOujmEYbJHeu0gTiGhwGYcg2b9X5IqEJNEM4MxjkgfcZchN3kL1bz+lINiJNWIzF
         zGgqY6RUWYac/JAXO9F5JJ5jYRt0FVaae8UP7FlSjNNhD9m+UFZLz733RHavNFzFPDPQ
         dueoDefL4Rlbv0MJcoOBr6BADn6WW6jesglLMWLzYPkxnwbyC7onuwK313uY5FSCt3SH
         SFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793347106; x=1793951906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4oAI5pxrIzXlsyWd5vlHzyNWwBTG6cTZg/AYjzhaORc=;
        b=m6S/ipN4nL3V62LJ7DUm63NeRZw0HxCIjE+E5pZhVZ02OvQhRPIfpkFQVIysj+onqe
         yxSdU3RiIqPolb8p/bXvg3IeZY3gz4llsgDvzi8t4xvvEWEq8ZnBGFYnD0+akaGWoIag
         rOKS0aoKphCN/ckl9mR5i9scyWo46wzvp5EweUd0iXJ8VZ0wI6KyqpFRKz0voMnU4ZJv
         NOhXMMMxQNZIuiKTiRPIQVsFTcZ3C5B3sLJfuwpzr+ZBPOkNpGpZnd0HQZzWrsjFboAX
         ZUJ4xwQ/dMSa/MSCe05Fm8awT+w45w1KPWdT42XpB8ZFjgFFcCoklgpNv1TNQTMX7sdm
         IC0Q==
X-Forwarded-Encrypted: i=1; AKwUvBwbW5x2On/D5ArEIWOlInqi8nPXEqN6Thi2UYhJ1/w59G0Mtpi/CqY8KjaGgxyfSN2i84AdTlQ/olly6w==@vger.kernel.org
X-Gm-Message-State: AFq9FYIJSk1CSgfr5JV/O7lbACitOHaFLmrD9satXyRX5PWxmjP03Hwp
	cWaE5ECEOpg8aAg/qFfP1MG3BqLZsKSKeVnFATFhUD0QGd+Tv9zdXGxb
X-Gm-Gg: AYBFou2WgXXcu1wZmQAsIECHnxGmLZ4qSgXUBq23Jr9XEE/tOBBjr5pzax8xHgcVlRE
	GQkhRocltcLL8cK7ZgRYRSy1rWHNqVsKlN4hAwqqk4pcqDhkBGtwpuWOJAQz4UckphgbCtFdj3A
	8GuurUNLdaO5ZtsSWLEgP1qjYl3G1vP9h4aZVpjhGX36amM6ZfHPCoVx2Y1V/LVBQ/EpL4FKV1L
	k75FiEFljLFV9JHqZNZ3jqXb2yRMIvSg8XV91mcDaUcd5Neh20sqhKVw3/8NdWT4IXWFxjVofif
	LuJsGQNeWmaA8FGsSIu2lZjGZSCHReSwewsTQx/WpRiZOAGOFT1VPNtci3wVyU8G7B954mnlNdy
	OUCuCtfGwq0k+MrVJwY6q6/S+qhQCNt0xoCFA3gKF4boYdvliYeN0tqZmK7s1HlxxP3RlfqGGhZ
	cwxVyHhOtcuiAe6V9q/9+LK+ux2CLNwC1UlNwT13H8fOGGyb/GnqjGlQuc5E0uQ8KiZIzJlWhto
	ZdBKYy1MYZFq2TxUcEf3AVdXR2HbqQXAejvMlpV8MAxLyKoeVvuusbdssRG+qWg39TOlv8H/tbW
	dVUi9Bjm78sP+6WaB1615Jc963zmlGZxqMwpFVktqdTZ/KV+WPJXL4lGZUZwdxzjjo8=
X-Received: by 2002:a05:7023:d0b:b0:1a7:216d:157c with SMTP id a92af1059eb24-1ac5de5380emr2405354c88.34.1793347106204;
        Fri, 30 Oct 2026 00:58:26 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac19c6b969sm4741054c88.14.2026.10.30.00.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 00:58:25 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
To: gregkh@linuxfoundation.org
Cc: jirislaby@kernel.org,
	dmitry.torokhov@gmail.com,
	mathieu.poirier@linaro.org,
	linux-serial@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhanxusheng@xiaomi.com
Subject: Re: [PATCH v4 1/2] tty: sysrq: don't expose a partially written reset_seq
Date: Fri, 30 Oct 2026 15:58:20 +0800
Message-ID: <20261030075820.207049-1-zhanxusheng1024@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026103014-sketch-headed-2fd1@gregkh>
References: <2026103014-sketch-headed-2fd1@gregkh>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg,

On Fri, Oct 30, 2026 at 08:02:30AM +0100, Greg KH wrote:
> I still don't understand what the root problem is here, sorry.

Each keyboard keeps its own copy of reset_seq.  It rebuilds the copy on
the first key press after the parameter changes, and it rebuilds it
wrong in two ways.

1) It adds the new keys to the old copy instead of replacing it (2/2):

  echo 56,29,111 > /sys/module/sysrq/parameters/reset_seq # Alt+Ctrl+Del
  (press any key)
  echo 59,60 > /sys/module/sysrq/parameters/reset_seq     # F1+F2

Now F1+F2 does nothing.  Only holding all five keys resets.  So setting
reset_seq once works, but changing it later does not.

2) It can rebuild the copy while the write is half done (1/2).  The
write stores the keys one at a time, and the keyboard may read the list
in between:

  echo 59,60 > reset_seq
    store 59
                      <- F1 pressed: keyboard reads "59" as the sequence
    store 60

On a keyboard that has not used a reset sequence before, or on any
keyboard once 2/2 is applied, that F1 press completes the one-key
sequence and reboots the machine.  The window is microseconds; I only
hit it with an added delay.

If you want this fixed, I'll send a v5 with a much smaller 1/2, plain
changelogs, and the Assisted-by: tag I should have added from the
start.  Otherwise please drop it.

Thanks,
Zhan Xusheng
