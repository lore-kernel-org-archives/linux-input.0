Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A1A40E8D3
	for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 08:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789375209; cv=none; b=tRVDFSX46tPR53mGWPkpbc0ILzmszGJDIxw2yiEC6zU0IwG4K9sHpL5REq86udmghhBmpqu5MKaEFEe1CAssyM/gVlUCVThYY3h+GSXDMmqLAgXXUMXM7a5M/Ce20g3FabkZnC3nBEr+Of2Uf79cCTqE0SLMZxCx7BTh2X7SD0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789375209; c=relaxed/simple;
	bh=S81+qyFwsfOGmk8DsWBTJ0XHZ5V5GlZfn960Le4gC70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kqaBNnhsEMSYOMLOfHYMXuHet4ZTHkOODxhHKvBMQNFCGbth2Wk1pnPv1MslfU5dDXygjYvXwhBAuE0l8DEgzH31QjmLR3rehXaRAcyGok1IU/3HpR4JpHzhKkEQCRN6bAjIOfCP1nxVc3HG7HLVYnejU792jUB/7EnppDHNPjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GDyqXeFW; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GDyqXeFW"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6350f89so775194f8f.3
        for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 01:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789375203; x=1789980003; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S81+qyFwsfOGmk8DsWBTJ0XHZ5V5GlZfn960Le4gC70=;
        b=GDyqXeFWAHi/EZvGcdwEX2+ttDDVdrtQEwFnVG/ntWXvPicZDOt8te1IBXxS3T/888
         pikc3ZNGtAyAmrvjJg/6C0MOMPegekD2ckOWHCaNwbgcNT5M6GSCfQIgHqkG4eTniQRC
         wpr4qqlU2qunEz29TrVQod1Vaz5gjch3Nf8Wk7thLUtaky8Bql+YIBBs+Rdi9g+gUiTr
         +bw1jVBdLUAyApFCkkku4Op5251G1og+knHEdeOUP2UDjztkCO7b4Fu/p3h0aUKrzYG5
         gOCyUGRgkHgJ8uY73r8Yc18V/FQVS4RUEaFtz/Fzv9AoDGX2/4s8CE7o5ddEKVQA73tj
         VdMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789375203; x=1789980003;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S81+qyFwsfOGmk8DsWBTJ0XHZ5V5GlZfn960Le4gC70=;
        b=QE+Cf7vC/NwhSNz4lHruT8fQ8P+AqRDUjrRa8c85xxU782uvkdeYzGrSwwXAXL+XuW
         N+CRedtQMH8HYulZ0rsd5fHvdyFDOXIf/2wImbsvvrpncJpgDjSSO2agyftoBbW78RoW
         EF7Wbext0YAlZZT3TtKLKbcSkCgnhw30M30dLALC4b8fLp5j9zG6WBw6afRkZrxdbDGT
         DhDj2MxeBxxMFalXhe/sjs96ZSsBNNTE4Y7XOFIyyEzo86rzUhWqJ/nGuVQlbmT6aWGQ
         kW5PdGXQgTWJK/W6qgkNhu8LNx/EIarFGeJraoyG7NWsLzldeO0xEGejFnqyDlSMdThJ
         AOwQ==
X-Gm-Message-State: AFuF++koxx6/YCpD9UJW+I7boMHpBemxVDkjY6v1pfSvoGCiwj6B8Gw5
	ycaNwiDWQtfrVF1gLyRyLQCGJkBgMkq6wKaya6xbjCNwir2/+yoaqoNR2HzEqEbBSci/jQ==
X-Gm-Gg: AYBFou1rz5B/gzRWT7KGnCnR84ZN69boklchKGWTnm9FTx810JYdiYsxz9LmF6EdGVc
	TOdFnFKzZmOZH88zThbgKXjNx1quqr02kTK1ZzAo9EmOaDfHSke8DWJZDxEumeTeTlRuDJqjfuJ
	6N2hisDKUoVcZFJUJif9Dg0nR7DFew3wGA6nIK7AO/nEoxv28Yi6lnSJ1pmfPZKSWS6INWwW7ph
	/ySnPik0OJLbaABXDnWlCwNW3kIRrzTku4CaI8rrDaIs1M9SDJt+Cz7HnNCloLId7TMiB55zp2V
	KzQUo1fQzvjC2Lj408hgKsKNYSHhnHm3e3qxZndhEzwgCzBoewkjRbRNAIb4NGcE7TiwbEulg09
	RIsSxQ95SOegsJ2hIqnzAUv5u2B9OQe3TpMv7euJLWW3daeTtjnemr+C7d5PD6Y9lz+7o8yueCH
	NMLtOFZUthtV1fDGe+b7ofDJ9E9eq72vxeu+n/nZuB9/sXFXGYLL/8PkzgVNP0zx5guT2bQyBkk
	5x1oog=
X-Received: by 2002:a05:6000:25c3:b0:487:84:96d7 with SMTP id ffacd0b85a97d-48702b3a150mr1472168f8f.53.1789375203284;
        Mon, 14 Sep 2026 01:40:03 -0700 (PDT)
Received: from localhost.localdomain ([94.252.75.25])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-486eb3602eesm24221897f8f.34.2026.09.14.01.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 01:40:02 -0700 (PDT)
From: Oleg Keri <okerixx@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] HID: quiet the keyboard on the Lenovo Yoga Slim 7x Gen 11
Date: Mon, 14 Sep 2026 10:39:54 +0200
Message-ID: <178937519417.10463.3332484043112843827@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910063051.4556-1-okerixx@gmail.com>
References: <20260910063051.4556-1-okerixx@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Jiri,

1/2 of this series is the same patch you applied on the 11th from its
standalone posting (the i2c-hid reset quirk), so only 2/2 is still
needed. Sorry for the overlap - I resent the pair as a series to fix the
build order the robot flagged, before your mail arrived.

Thanks,
Oleg
