Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795135830;
	b=r7SLqZWhzuexwiE0ky5xVrp8p4VJRoaE+kPX7xOpxPGdc8onB+1S0P3ByCTUZw9ICDYQ
	 HWYI2zXwNVCa6ZItnLkrwReOPMbRxAmlxj8zuxR2XnDkYw8FMNRYrbbxiKG3TDw/m39Mt
	 +igxIYLTfvavJgo3o8qgFQ6s+AaTgEJKJcyYwK7z+LI4/aiGfX6TFowwO4w4Dk4ccu6qM
	 BChXxaLJVYZa2wT2lWUqy3gJqH1X0wSlbyzvKLbDi8OjKL3Xfb8Oy/BvKNRLzB5XJGZ/8
	 W5weXEW+n0YEWh1rBQqBB5wKe1B8rC1J7JcO+Ti4bEtvNXlWpHJUmwcktupDe04SjoA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795135830;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=4pQ/jBdCGos9KDlJt1J2TDwopdBtnvMOQDgM0Dw4Uoc=;
	b=QxvXURsom8fwgnsBXaCVGSFzihL5ImVZb8qJO3xjbRDcqCdqRvA5AuDXsJ5wwL83+Gp6
	 BWdgoPCNMF0a2zx1CagF7yq771OTWXYcJSdGvOcIkxEr5KT8DT5LRx+MFOqIc5Qgs6oPe
	 i7be3iIeeOG+UP5/fEHe4r+EwFtwwk6DRImNkZmJotwPHFjc+IiEJoKBdjmj+hNESvXFE
	 0DLJU45cH6oLJDAJEDvIHxQ9g3swaGPK3xpfw5h/ahfDLFSlpTTK8pOrGh7OOZcw8XAfz
	 fArc1ZftZEf7E6J1/gdqa8pXAYWKOM10Y2re4tKnlcPunLA1Pbn6VJL5HFUwgG2vS5Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AtGdGmCq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.171
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1C5606A326
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 00:50:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED1C5606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AtGdGmCq
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5c9e7731b34so275155e0c.2
        for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 16:50:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795135829; cv=none;
        d=google.com; s=arc-20260327;
        b=DCzSkDYDVhC+9lQ2lr1CeecNE6BEvdLLyvjgd6IqqSsFl/R3KRvF35mHsE2Pwedb7a
         Gm5Cz/Mk5tDNENhGQOdb64bZOerk+xAQc/k+gTzccu7BT3k6xmsPqiC8L8IeuoRiTWQl
         pboJWmEKQPVexJBYw2brxq7ziVVpD5Z+4+FSTzsV+c5vSNGwF3Hpg0dfzwx2NWh56Ovm
         evzv8T5poGBJSNWqjESynVHja/M+5WwQtbfRLWASEgPdTbhCRWMxZYRH8TWqyvDfbbwc
         HYmhZ60xdSpDMFmiyoFbxWFIAk9zoLNW/KvgNL7r/evO+F5kfM0WgUKp3M1xOsdJMnpT
         XGSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4pQ/jBdCGos9KDlJt1J2TDwopdBtnvMOQDgM0Dw4Uoc=;
        fh=zp1SgKw0cJdDe49epj7oiXmgYi9UjDoqq1FqR9QVAsA=;
        b=BA4w4RPdmoyBNQwTlP3jHqNR1mKdZl/uWfppJ4/MrmULdFmIWNTvzXToHt4llElCOo
         YIvhS2vqAmJG6i9p87Pjne6ENS0PkO80SJYkOji1CwpYXPDjLkGIv036rq2vBJMho6m+
         VGraERrCAKOTIBIXJQm9ywGrAYS47AkQpujfjOX8gKwHLPWbnX5DJeJHqhUOevLMWILZ
         ROlHspFwZ7pnAJHgbP1/E9BzadlttgHzz6JcTfsNSDCrAtmlHDCavBkcf6ZyRIK0YLhF
         m7JU6e1PfUpt7dRgfJc+rk5Dk19KIRAXJdOZhd1adRla90LiyPx/0OwNQdvhWLZpjzzN
         Uv3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795135829; x=1795740629; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4pQ/jBdCGos9KDlJt1J2TDwopdBtnvMOQDgM0Dw4Uoc=;
        b=AtGdGmCqYWoBagnroC2kHC0RNlIUQFcdGwFSfIhmpAOpSH7S9OzAMR0o0dof16ztpp
         XdEGWoEjYwLoudW4mOupNda2yO2gEZ3dC1vzTXaIBC9Ve/A9Wqo4Gm211szeC/e4fJwz
         xa+H67uKRR+3CvqeVV7bX/ZMWcU2pei4vqImjg5FQJ0VmhYJo1ICNX/BU0AeVCPlYlJO
         hLTboBdfqd5nAnzWH/gwtY6OM/kQXnhwrttMbfXUlor4OKXg4BHgB+9TdJB47/JiiQFm
         LcugDJtKsfoJE6dieQvhm4pB6dPV0dc06673o4joi1IGbyHOycbQkiF4aEQO4hF9HFr9
         +/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795135829; x=1795740629;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4pQ/jBdCGos9KDlJt1J2TDwopdBtnvMOQDgM0Dw4Uoc=;
        b=tA1j9cHMcn3FoaJ/XX7qdgQoW9wE+VxyonuBYmiD1NrtqwayZ6hx1kgfGsjd8sIv5M
         Wp6poivbZlzfPqjmiZZCQLE9Ht/eSw8AHNn+O4fTwRrnbtFPFxmCNv0T/5Vl4pb89ql4
         M0hNM5QU9cW6zJWQjbU0IZIwRkMxFAzvyeUzV/VRnntRVRvJcMJT2T70alfX/Ciuvccb
         aIaztACmLDNK3Z+OxhjR0I4Mlb64Vt/BdpmfSB1mUtuSfL6oo/PhWensIj6IeuH3uNKd
         5zGosgY1seC4KgitNKzjiQqsn4q3P2VZKCO0aUJYxM1tMpQPgaD3Ljb1YVxSkqDNdOEg
         tH5w==
X-Forwarded-Encrypted: i=1; AL+hErGnafmqpObmjOii5y5t5hrb+LaBT4Cm9uAwRKo3vwN41Iu05Of9T4VpoNyAwhml2RHKUC9+N+fiWKBXVw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8XC1d5H0qimY3ldjU79+ni0qTGiXtjdw46GoMsH1ApeZKOKcRx
	wwyBy32HCvnMKGugpub0F2hFElVLeHNvD6cO3vs8Z2SX4LjEMm2Ia6I1L0zMSlTaZ675Jp7seyn
	pl8CEdYNPcm3s15q3XFHD53zA3vHGf2525Q==
X-Gm-Gg: AYBFou3PB1Bh/E8eyER2Zpm7pBt09VcV/LOh0kxm3BM2XSIT+DQ079xfNleEQrNSdtR
	nGINdw2p08i8Pnn3WJWVX8ROC9nNE5dJvPH/M3NC4wHv1pm7kmgNEQ/szc0KZPjQkZ/jdkm57AI
	3I60pUT/ERyVtwqe3N60wPJ1tHncfK0gjUEyKE764irQjyiEh540izqCHqAoisU9dR5tZKfZp1D
	7j8AzVdyp16/ypUGnBZePd2dvVWmplayMoDKoxP4ik8Tng/s9UR6j2lxOIN3L3fjQD1ETgFUJuG
	MElge3jhgcm5yaIBpBo9q06MqXhoXj5FZPXqYeMiqAcsmpQY/+uF28HLPB5Y3MTeL9DszXH4dFi
	CIeyRLoDLdlHioO9hv9fMmATwSsAgaLYIKikc6RELcVszIsfu0o2ofXS49bsB8MgRG9z/9DufVw
	yA6O+hLEIRVv8mvZjd09vOfqPloitoZFreR07CE82WfBRSaN1tdlQaIjCm+TqjhZDwrQqX5S9nn
	Lec4IPK6rs6hswWADQ0uplLV2mCe0LJNcT3Ish1CA==
X-Received: by 2002:a05:6102:441a:b0:7c3:f36:c7b with SMTP id
 ada2fe7eead31-7d739460f73mr627739137.14.1795135828903; Thu, 19 Nov 2026
 16:50:28 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260930-b4-elan2514-irq-route-v1-1-44671bf01d05@gmail.com> <75148n0r-r943-9304-n194-r66rnnq660s5@xreary.bet>
In-Reply-To: <75148n0r-r943-9304-n194-r66rnnq660s5@xreary.bet>
From: Waqar Gulzar <iamwaqargulzar@gmail.com>
Date: Fri, 20 Nov 2026 05:50:17 +0500
X-Gm-Features: Aa3M54rs1VLWPrHj2w7hmXHghKJVCZNUY4vPO1mwF8EQIcxkzA7-LKDhDSyrkzY
Message-ID: <CADeB2Yom5E_0MwW=9i6RATAEFBmO+Q+ygR9efN84S1mtKVcE6w@mail.gmail.com>
Subject: Re: [PATCH] HID: i2c-hid-acpi: restore touchscreen IRQ routing on HP
 OmniBook X Flip 16
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 20 Nov 2026 at 01:45, Jiri Kosina <jikos@kernel.org> wrote:
> Applied to hid.git#for-7.4/upstream-fixes, sorry for the delay.

Thanks, Jiri!

Waqar
