Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC3D4B95AD
	for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 16:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792168741; cv=none; b=gC1u8tmFNYYhKnoR6QBGJfjI3sYH46LcqX+8SZjIXw09sY417xG3tQltWdefwsZMlVFVF7R7fP7e0hbflyQomtKuozB4MasNJHR5Yzp4vBFWVoAyHfYDwvvPClBavPdtPLRC/icwBjUvTObJQu5tdCqBIocxvROqWl5tbB7oUxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792168741; c=relaxed/simple;
	bh=FxEVgvNwgROcpgS40eg+/0VB4E+ZMgfspJbjmomvovo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l+AvfK4H0Ujf5KOcO2GPeGD6Cc9DQGME4k88xxNT5x9r54gihsEt6DbIss36uA8leHe7Jnzyym5B98CyGG/B+wCsGxdJoyrpgjRXnb3Ssgl8yfvUPD0/GMg74RLjNppnmTPu6izRocssKBR9M8coZ4QDxTI6nCxsUlSCEcQSgO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BKnrx4OL; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKnrx4OL"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-89ff475a152so52542b3a.3
        for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 09:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792168739; x=1792773539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=quWXEdGzPaplUtxwyjvdAHT/D3hcP8quVKx4GUWHQG0=;
        b=BKnrx4OL+DIzDGhCeVXrHTr0Iyp/KL0z7B385yAyMaFS5fVHE16AWJAxPz90Ho4JgE
         bIEbPpCLE/ygKxZc+F7ZhzYrM3KkXXxlQ5/LHqkJ0d/FzE92TABFV47NEB/asOTSJ/a4
         8zWi7lJOpb+ABntEAla5+hwi2gI/fgubdCbwSmunG2YeH1Qr6plDdhOOTtP3WoYXyN1N
         GEhxI/Qg/9EjmmKu9aCyhCQM2Tv4mo5K1HG3PZFsyEYkrsrBCjssyNncUe6hy5GHsSsb
         KW2wfA2Dfsg/08CSLuKjdJjrEgz3BoQv8chlxuKRnfmlGHbyTFikjI5im3mXFYlgBq8O
         UWkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792168739; x=1792773539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=quWXEdGzPaplUtxwyjvdAHT/D3hcP8quVKx4GUWHQG0=;
        b=j7VsUXlpoocssEQd6qUgHcxRLjx3bNJeYqSknKzKffW33zdy4QIk39GN6ubWoFnm2W
         MGRuNgBgySN/oddIuvTVuHJ1ZCwCPdRV0T2Ym+6XOIWOwxvtBLPVKU5IgEKq5rwQh9Vi
         hrfI3WmqX64+NCqYkko2bttUhqV61a0WT4PgwJfBoZR9cHgHdTig3PZrTFWY3awo4zq/
         ilR3C0CIPZi/NAwR6W/gfgCeRBLA0pE9w4veBbxNjmOn3RIeSwII0wLrt3a71jnn3yyU
         yhrn8zgJ9D+XnasgiTkfmy+NkZ9z0mxW4Zb5GDjQcZTgMM/6NerLSwGHzVm7t7NqMekR
         H2Iw==
X-Forwarded-Encrypted: i=1; AKwUvBxMCExxBF84QYl+9IHWwUF6fV2qJZ9y0ljY5N0uIiAUFLLft1oZUBYii4wWekIUi2aM9XAPZw8V7LJymg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJfrIBHKqzo2dreO7UkTcFI7R0t+RXgilzqM1tL+vAJksMGg4q8
	lKpgExHIh0ob7JW+DAW14flDEno9tITCYMgDP/nGpQF0jji4fjbZX0BF
X-Gm-Gg: AYBFou1NU6sKQI5Q4Ug256FE4XdORNutk6NPonWqLUlsTW34nVUPREb9MqUhwWPpAVr
	QXzCH/p7y+MLEScUftSyMJNS6jJdUA702Zkl7oHn7Wlm1H4orgdmT609PGsSe76jMLdc4pIF1TO
	/5z/woKOJApY45ULQbw7CzOl8ThXC1sGQDgrMQv/jShO9doL0hwjafz/YB5sy1R8P7oLd81TWKJ
	XbZpfRkLH5lxX6jDM3vCdc9tVs7k/KKpQE0PGiGYdvpyxJYrZ0uyHp2CjI18LNSVg/QAN/mdjte
	pNHQq2hYt8CDSqlbp1BFoz/Xxr1xRLDua4aeusc/QFH107Z13LxAKXxZrIoCpbA8R4Jsu3vQPZe
	2PYFpP7oTNXmFi3peIVbgB6px0j+lIPX210LlbQ/cj+sMGanblGugRSLuMmghCQp2S2qhi6MrrD
	fwnKn/gpRyFKa0LqDU8n4YR5jltxvlG/u9tj9kmIY2mx1NLoTlqltKIRxjkhtlk0qVhlM=
X-Received: by 2002:a05:6a00:9518:b0:878:6ee:672b with SMTP id d2e1a72fcca58-8a04be3688fmr101852b3a.35.1792168739190;
        Fri, 16 Oct 2026 09:38:59 -0700 (PDT)
Received: from wyb-ms7e59 ([38.55.195.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f54b2eec9sm1406945b3a.8.2026.10.16.09.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 09:38:58 -0700 (PDT)
From: wyibo6109@gmail.com
To: Rob Herring <robh@kernel.org>
Cc: Yibo Wang <wyibo6109@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: input: add OnePlus pogo-pin keyboard
Date: Fri, 16 Oct 2026 11:35:40 -0500
Message-ID: <20261016163553.1069372-1-wyibo6109@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016131159.GG5059-robh@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yibo Wang <wyibo6109@gmail.com>

Hi Rob,

On 16/10/2026 08:11, Rob Herring wrote:
> Please don't send new versions as replies.

Understood, thanks - new versions go out as fresh threads from now
on.

On the same note of getting the process right: the binding
documentation in this series was prepared with the assistance of an
AI agent; I reviewed, adjusted and validated the technical content
myself.  v6, going out as a new top-level thread, adds an

    Assisted-by: Z.ai:GLM-5.3

trailer to the binding patch and the cover letter to disclose that.

Best regards,
Yibo
