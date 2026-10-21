Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792546919;
	b=vTHeKSM/r8abA7asSr7SGlbSq4tsKshbLBQPPhKwFb9qCl5cxzp0AsDevjxObvao2D2P
	 ZFzz3EhZVfR3+y18S9Fu7eYab/6BpMrmWzS1Eq6qy6dGujEGNI5f6tVFw9Lfm91f0uLhN
	 ayc8fwHLZYwqhjRM3Yybw1FbA1NL1qp3cnNHQws3AAPSFkLGMgbnA1OTJ4MPliPpBCrs5
	 Bl3dZEgc1SJm2EW1iQEs/4ya6S2q9US5n4hS8lA5ITacFv9jdNrOvn+Hr0SArNc/uu/bR
	 NRD7548m9YDIbY4p+GziO9F+gFblR8RNi2IcQzEtvx41jKVuFVuziJz2PJL3KjV+3bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792546919;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=bEk7FecfY4nY2BV2BtdF4RroL7r8NrfcNW+Labz3ttc=;
	b=J/F8CnUvot4vr4TNVucPj8zzgB310/aTwJKI8zmqviceFgnm23a3476nYbxTrRu6gXWE
	 vPzKR3RPSQXDWzOIXllnNlnsL0KQIgo7lJfUfCM7RzlHxfJ6nzkmCNp1bXWPLt+F5Z8lp
	 9BGb2HpctKsbfHMsoUsGIpiRWhlTmfHXW+jqUDrWPQTZtn+XbOwQnKjSQ/gJaB3W9MktO
	 6FFXYHCexjA8n31dyIN0z6+LFgWo02gpDB/iz+nMLstZaau0i/vzrLbWxXY8p3siW6fVv
	 rzf2yRLitaUI+dYkSrCYddl8inDU9E91V5o9oDzs/Bx9pcLfNpOhF1tBuXp67pJydMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MVBfjRxU;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F083606A31C
	for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 01:41:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F083606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MVBfjRxU
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-17bc533fda3so270461c88.1
        for <linux-input@vger.kernel.org>; Tue, 20 Oct 2026 18:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792546918; x=1793151718; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bEk7FecfY4nY2BV2BtdF4RroL7r8NrfcNW+Labz3ttc=;
        b=MVBfjRxUKnJTPV2PbUgCrwO6K+tafK6pr315kXrirjfWGz0HxESZGdJkFkFw2d+aCY
         gZusa9//Cq3sm0YTnSxUybcFeRik8gNb6Mz8tb4uFW0Q0h0ueYFa3ATAyFOIrBR0xzpR
         y11eC3o47YA1l5CSdaU7cdaXQputkQ/2F07/fchjp4McxwtJOYs6fQDazoDN5yXaMRzf
         b20n7g54e/oF8h+TaVJqsGRE1ENHbu3fGCNlrEVnVnD4nD9LdeEZq5O4Iz+vbt39Kcj+
         6d1C2t9Y2kE3kJWUi1OlYHZbEoqSLpt4XtzMdLPnyuhuQAScR6WvBY2FivJ3tquuqQgF
         +I5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792546918; x=1793151718;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bEk7FecfY4nY2BV2BtdF4RroL7r8NrfcNW+Labz3ttc=;
        b=Qxxgv46GUFl1UNc6viQJYeFf+x6jylidmUrVCTcFBW6NRyCHIKbX60llOuFZWEikf3
         VggOSvo6E7D2eNUsjtHMxah3nTpxMjJZU0Bkfe1JgFBDKBv2Zub07VNsbCMql0pCyt3U
         tH9R2FduiJ5PSM7aJ8JMPMQHeB5IIOvkhspgMWM0tA4p9oZUrT4AGzmIRiG6G9uZBvWr
         ZkaN/WNyr+NDDI1KNWY9JahgTmDi/hgEC7KI1SiF+JL0AMgwSRECQCR0a+lN/Coy6bqF
         clnm6jhgBRYmZhi7mLy1ezYtYpOhCupTRrZiD9XQ7lCWuYRUcKIWeR6DZNla/7lYymV+
         32Vw==
X-Forwarded-Encrypted: i=1; AKwUvByNun8sVIAc4vynBDvIaPCxHMJoGcZQugkV0UYVnDxfHfSGuq2ovN4pFOCR2TD1sc8HQ6j1HXYzuGipTQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYKeJdEExHfUTn5qvZfiLLQTJkWve6Ri8sYYoztXNOWFSVu4bOaD
	k+oRMTVBQAW5fvxmcv1HLqYhhBewHlcpI5Kn/hcti8FyVTHBoCmhtJB9
X-Gm-Gg: AYBFou0tpdtjaX6BM70SzzM2+18askPq1FaXGOgPzQJQW63hMqo6auoyeqZVS87BlPf
	+jxbY23QOBlDS2KzP4rUn6lmWXw/ATBaDQKKf3jBsMRyg4Y9ZtSurjss54jUeuVh1FoyLVAbRlY
	9J10KB/uZ8n+xgLuzZ241KkMjgadaG1tAoCgF/5SkVmhewNe4Pry/x6qre+Sn/M06X2nspA9h6w
	zZC+Kmn0kKNAAAMqYsKz6+gmmjBCblU2RmbRw4l2GONbcg6IKBSZQKDwmzkCJZSP4Ahg6v8dHIf
	LgIjC7jE/m2g12kdiZoPKZy4HY8pN536H8BqyU38NH+9uwBHcD7V5Hk+UdkWCWOP9OvfkXJeCRx
	OKrmaMv9dRFCjzyxJoNDf7Aoe1KithyrTcpLN2pYdiiHSNuNYEQwHdo7pBKeVSMVkLFZ6jHmJjL
	/8LoohpM9GXu0JJNkDCBAD1CSuWMmvw5TWc3C528QjYHAehKg2oniKUashEjWY+wd5e2UfFJsmS
	ZeeKKwc56uPiWHrpJ5BsaYTM8mFw9PfwgqA2TqLbqoY8vkVsGEqmTCbdhSJ0g2jT+vJePwO+wKW
	9mfMbYVjEgLz6NNfrbyRqg==
X-Received: by 2002:a05:7022:eb55:10b0:187:cf46:4c51 with SMTP id a92af1059eb24-190a728a309mr818013c88.31.1792546918290;
        Tue, 20 Oct 2026 18:41:58 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:92d1:8038:c4e7:1f0c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903bd6b7ccsm2072834c88.13.2026.10.20.18.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 18:41:57 -0700 (PDT)
Date: Tue, 20 Oct 2026 18:41:54 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Miro Kropacek <miro.kropacek@gmail.com>
Cc: geert@linux-m68k.org, schmitzmic@gmail.com, linux-m68k@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] m68k: Fix atari mouse movement
Message-ID: <atgXH5V-q8fYe0u4@google.com>
References: <20260819222838.21256-2-schmitzmic@gmail.com>
 <20261021000338.2160223-1-miro.kropacek@gmail.com>
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
In-Reply-To: <20261021000338.2160223-1-miro.kropacek@gmail.com>

Hi Miro,

On Wed, Oct 21, 2026 at 10:03:37AM +1000, Miro Kropacek wrote:
> Kernels are built with -funsigned-char since version 6.2, resulting in
> the signed 8-bit position deltas reported by the IKBD being
> misinterpreted as unsigned.
> 
> Carry the sign in the type of the mouse interrupt hook. The scancode
> buffer is shared with the keyboard and joystick paths, where unsigned is
> correct, so it stays unsigned and is cast at the single call site that
> passes it to the mouse driver.

The hook receives the byte stream, so I would rather have it accept u8*
and then do signed cast for displacement values (and only them).

Thanks.

-- 
Dmitry
