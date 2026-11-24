Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=84.247.164.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795546994;
	b=mkcMfhLhiartq/FvO3196//yrIbEro235Lec1IIdk7bEmzQ71Jhlue1ko/OcwITII5pD
	 GGkgaAKqsmA16bFHVjiwO8xSqRNXQ43fuMy03CCHa3EdIuoZ/VBi153wgfQ1gULtH2re+
	 L218FEQWsfTAVPGWX1mV8za3HTNh5Je67SD5FREo3hyRp7XLL0MzAlr/huaYszXoi+KjR
	 /4GPEDpfeUihV21COpfzcH7gjvDS7Bi570deeskdoVtKtPR3J8Xh02hkrb1TM3MQVfD07
	 x44lyakb3NzcpATrn+UpK8oDDnQ5bfJ1y+nNQty1pOcMadkxdVut9K2TElpUxq3/r/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795546994;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-Last-TLS-Session-Version;
	bh=QGq5PsB747fFXnGhwiZmxObJKtz9XPqM2sIVwZUd/y4=;
	b=NTJcsf89hMRiRV+aD5Q5ZnUKc1qJ5KcYqJK6NSxv400Qy4fAg7zHNcqF7BOidqLLMtNU
	 bAWNtQrh1yKAzsfiyL0UusqTy6B9NLPSMBx3SlmhC2c5wgEuKNhFpvBSZrt5qfCTF0qE0
	 ldTJt9kW519lNR/tNRGjlJ2jdC8z109xuH7Jq2JkuThCx49j4dyUZs0T1m5vTp69fM8ww
	 TQHasB5dr5nKRXRUM4UoIAcw9Ux6dDTWNmVldCK+1D8ahvUOWlRVUqI+hzimbLQAAT+Ra
	 tLSyBszvR5kkgtsBEk+kSoaAoXaPeUSasNwfNBxRZwagE46RNtY3fx8BTtDN1e5ZksA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=koesling.info;
	spf=none smtp.mailfrom=koesling.info;
	dkim=pass header.d=koesling.info header.i=@koesling.info header.a=rsa-sha256 header.s=dkim header.b=Qo4TrMZ2;
	arc=none smtp.remote-ip=84.247.164.36
Received: from mail.koesling.network (mail.koesling.network [84.247.164.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08594606A31E
	for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 19:03:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08594606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=koesling.info
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=koesling.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=koesling.info header.i=@koesling.info header.a=rsa-sha256 header.s=dkim header.b=Qo4TrMZ2
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BD6C61320F7F;
	Tue, 24 Nov 2026 20:03:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=koesling.info;
	s=dkim; t=1795546990; h=from:subject:date:message-id:to:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=QGq5PsB747fFXnGhwiZmxObJKtz9XPqM2sIVwZUd/y4=;
	b=Qo4TrMZ26o853Ex0sxhQkNu+yXhvP1v0hF4li27jXMj+bS1t0TtwmGF9qnIWjG2MRkvxZy
	YlKvDYTZe5Xx/u1WAz8tRkCp9LmJAHutFcRIf/HZ2n863LzJKd6tTi7SydEAJcA0H1wjdh
	vc7AaLX6V+G1GxXadWi+sUie+cKFfvy9/NnQ8jD1Up4VLGvqxPKw0fkubCrWGbLwXK00qV
	qZgzpkcJrnWlTJlZ2d0qROS8G2pJiyyRN6nL6+ezTyMTAcRjBPuoBuSUJQIbZMK08nRhdZ
	+1n+qidYDkbdAwr3/b/aAlXpdL3NNgJ9bw54VUvJ/vKQXLocHFw9nibTARQHaw==
From: Nikolas Koesling <nikolas@koesling.info>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 linux-input@vger.kernel.org, Aaron Ma <mapengyu@gmail.com>
Subject: Re: [PATCH v2 1/3] HID: pulsar: keep battery online across RF standby
Date: Tue, 24 Nov 2026 20:02:56 +0100
Message-ID: <A6gMEca2RuWRV9y7NPDk-Q@koesling.info>
In-Reply-To: <20261124141315.6745-1-mapengyu@gmail.com>
References: <20261124141315.6745-1-mapengyu@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Last-TLS-Session-Version: TLSv1.3

Tested-by: Nikolas Koesling <nikolas@koesling.info>
Reviewed-by: Nikolas Koesling <nikolas@koesling.info>

Thanks,
Nikolas



