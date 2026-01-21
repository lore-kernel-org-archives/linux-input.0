Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B789428467
	for <linux-input@vger.kernel.org>; Wed, 21 Jan 2026 22:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769034465; cv=none; b=omTPCy74PltdQ2MkqluwGqiwvbg92fAtUvtfs8NJnd2Q+3avaEgWiKdsIO0i0hna7pqMLjSK8C+z3eVLDFAu86gqn94Zxll/m778WqKu8ehWTUQmjgfCILPDUNcrwns+6SzzuBkhCUQkTE8Ana/ArBD/sxJ1CWuSDqjKmx9R2DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769034465; c=relaxed/simple;
	bh=dcc6XHJt7zhCvM2k/wZEktvho6S1vYD46R0gJ7cFcok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFkI+BllfoMsLF8BrbVMyjMcWhzPKkkcIF1Trzl6rzYE6mi1Oh+w3muZjO9gUpxHkTwxHN6cPlPXI2SvEd/DxpQPMwsnk5ct2ls91dDjfAreXysrtS5uQZdRu4oYnwgkP5KtZaceYApxukTFjKkfE+Q6kgxLUciT42bm+aK5uA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHF5QIx8; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHF5QIx8"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2b729f4c154so16772eec.0
        for <linux-input@vger.kernel.org>; Wed, 21 Jan 2026 14:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769034462; x=1769639262; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4XYXlIMcgZLCM9s1q5+yMZLxyDYaGJIq0MWW9UYa1v8=;
        b=aHF5QIx8740RH0Qx+yvy8biuedJL1TzqTyjEjoNzzGN/Gh6jwYFAncYrF+SDrtb/Nb
         vhgnCvjwMQ8yLBnE7kxxBhJ1emhXBbzuE0T7WabX/hgTiGeMvGZOlj9QN8krjh4fTASa
         uV6S0nHCt/JTZfVKxnHkSPL8/oLk7NkuTFJx/SqgImVsUoHE7JsA/mTqEjBCXtu+1iGj
         AI5sGTbR5xmPhAkV3WjHHAkq2YyerpKUm2E3uUVeKoVgb3tS3r8cM5Bq2Py8DwPwEf6s
         opnlFRzTTQgT/G2mia9+mKuTQSsAp9k/h+Y4Kf8i3aFxwqhTGm0KeEsH0l5lf64thhSK
         XFDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769034462; x=1769639262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4XYXlIMcgZLCM9s1q5+yMZLxyDYaGJIq0MWW9UYa1v8=;
        b=t0CL9rZ9Osrk/toqeFjfPIEd0KnnjFIGp97iedJXxvVYLRLWSAxedeaUbBXmzgSzL1
         S7797U/odu7Wkrc1VqzqIIHW2qWi9r+qcVtaaDqLC1abDQ6W2wLCRKHZX8fLvVBN8tLO
         BMjGB+ui8/AGtgXc2acVALCAAqvvYp8WcJ4/+NNmZnJ4BFdkIYnSxcNE1XdabeRHcZj2
         9gBPsH4iARP5gnudtaqM6fy/63UOX2BFN0Ah7xTLYwKlCcuQ10Qe5+TBJoX0n9+iYdHG
         ADRks5Qbm7kZE1t/k4wMXpdFO7Crz5jRakodXn3Y2YMHiqoQSv0rU7fyGFfVFmheACkO
         ZahA==
X-Gm-Message-State: AOJu0YwOaCa3VWCaZbnp22sVHkaoyqA8zdFRNleE3mWuMDW7sApn7Xfp
	3nWFHQwUzSMho3WLcLlVy5APPZSqKu4WvbSzrudbmNffa/9DAr6w/XYZ
X-Gm-Gg: AZuq6aLAhkOe1HNmefvYI3QRXeVwW/8XwoZZjvpAxHSsh68VEaJBJk2wu6z4znu9TNz
	TIUHj+DGxaO5l4nfhbFSE6sB9hUDfwqOA9MqQbNyZLIilJdtW0wZVmnswQcd60nZ7g9OXOgaTBH
	v8KFNcrOTMgs/+yLzXuvN/X/3+GS/IRRv7i5JguA2ppBjvdnTIMRb8jV77G9bSVx0xqC1Ofby9k
	JR0V+PXb1rO7mh0A7XWBbc17N9wBElOMthcr3JpjtH5qupWLoTqdag1k25DPR+8t0m7u5vQfrgX
	XZBe9rVMEFCfqE1kYiAXGxMj3BHrCZiAdzjU1ErDhsGmcMajjkzKNROHaB+W8G8rG8nJ6l13itF
	HMff+KgfTO0/4zb0GX+uMVaXjx92r7yz/UNktVryaeAXpRUsCmWmUs1TrU4yp+iGEMC1Xo2qeg7
	Ck/zry3QfGbNUA4baDEnnoMXsISrtPly7YcqkC/mSJs++p2p+cYJvI
X-Received: by 2002:a05:7301:7bc4:b0:2b7:1a4a:d564 with SMTP id 5a478bee46e88-2b71a4b62c2mr1515970eec.42.1769034461980;
        Wed, 21 Jan 2026 14:27:41 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:abb8:3a31:328a:3594])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b70d7f729bsm6694050eec.16.2026.01.21.14.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 14:27:41 -0800 (PST)
Date: Wed, 21 Jan 2026 14:27:38 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: daniel_peng@pegatron.corp-partner.google.com
Cc: linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: input: i2c-hid: Introduce FocalTech
 FT8112
Message-ID: <cmq5ywzrlmzvlinquctnxnm67h6xmgpigcu3fler56nrg2fyl6@jzm6o5f3g5ki>
References: <20251117094041.300083-1-Daniel_Peng@pegatron.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117094041.300083-1-Daniel_Peng@pegatron.corp-partner.google.com>

On Mon, Nov 17, 2025 at 05:40:40PM +0800, daniel_peng@pegatron.corp-partner.google.com wrote:
> From: Daniel Peng <Daniel_Peng@pegatron.corp-partner.google.com>
> 
> Create new binding file for the FocalTech FT8112 due to
> new touchscreen chip. Confirm its compatible, reg for the
> device via vendor, and set the interrupt and reset gpio
> to map for Skywalker platform.
> FocalTech FT8112 also uses vcc33/vccio power supply.
> 
> Signed-off-by: Daniel Peng <Daniel_Peng@pegatron.corp-partner.google.com>

Applied the lot, thank you.

-- 
Dmitry
