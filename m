Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4133E8346
	for <linux-input@vger.kernel.org>; Mon,  8 Jun 2026 20:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780948942; cv=none; b=tQjrqtopkPR/UCD4a4hAeFt+WZVirL91IC6XrK9T/1/PuPavqPImXAMEBGvYMCEwmfnJyG1jbbEgfY2tgnz4fUFtmyMEmcnPmPadwZGh91dbK0mtrwr4GVF/KtBSkjga3UhwK0VD0pkabE6ObqlRwrfHZVeTnv+2hJA7Noj12TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780948942; c=relaxed/simple;
	bh=2AdxBUjjoRIz4yiOcp/UhU6NOMvj/fYXWd4qBKsKTJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uPi+N2mk6HsQ8fQxTfxj6Oa/jKlQaP73oKcwlkt2E3sV0TvkSluw7xhteokuOFVgXS8cu6yBtSJjLRmSvlj09hE2iuKpr8cT1G3BvjdyTn48GNB+VmauQA+48o3pRylziyeCMPiu5Gv3ND9kLlvqt7GsxNwWdEe2nKYos8fEfwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UAEQMjgR; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UAEQMjgR"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-490cf3000f0so18213855e9.1
        for <linux-input@vger.kernel.org>; Mon, 08 Jun 2026 13:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780948939; x=1781553739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2AdxBUjjoRIz4yiOcp/UhU6NOMvj/fYXWd4qBKsKTJg=;
        b=UAEQMjgRuo8nkoEyZ+HI/RkA3SIh9CVPLiAsknscaLUikkpFMmHUp6rkUT+Hb0iKeO
         o0N8yeuUjTJLwg2xsYTHPoxga5LNjsz35YkH/eklje2J8qtXpeH3psQNVDIZcYOtGS05
         BG4J9RG1GDtIz39L6UMCp8nMZdAk3V62buzfi/5X7jvxcRzPIGq6ue32mhVQi9PQKr5a
         sBiOYO9YdtasdgtUKk20ZIaFL3OYmmHLEYg0X3XmcH/9Vh6k8LW6JuW72+eIsoB9UUHa
         Zsig0fqdAP+KWo0thQod7uP4fJcKzUOVvj2l8B6IefSgTRYdm52fps4Vs8e33RJ3CcvJ
         Qt9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780948939; x=1781553739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2AdxBUjjoRIz4yiOcp/UhU6NOMvj/fYXWd4qBKsKTJg=;
        b=QdKdoDeOqHSAg52nvLsFugAQgs+a+MObZ2JC7w3eoQ0c9p9A6fcNy96Y7UQ4+Hgi3Y
         wsCRQX+XCW/nTAGGUPXdbElWVqK3YybaxcUKPsFK/4vQuJ3sJa/35V/9iUWyu9vO1VDf
         Q+wdp9sBiJblOnoTvS+nzfaNAcHvQeMYx9F9vmGGfajsMGfq+Sijg0zd5iUhP9ureeWh
         wZCLvb3MQS3yE+4Hf4lRiRziEcRCpwoBdKMPIPcW99S6VTVPZwEM+ZOpiRY5CcX43Zvn
         PiIwHYsLWNYXTIJ2Dr5XeltWx5V4F/Kw6p07f//rQlntGx7NZuBa77KppoEiJh0c6BtI
         yuRQ==
X-Forwarded-Encrypted: i=1; AFNElJ/M7U/dVw6KJIt+em4Bh+5vGicrizgj0ULDn+DWw33bBLXMycu0V5dqE5YIBjs8HriSlXGfSEq6MFu8Sw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyiAiglZpu7fKBaIUI65opKw1LyTxcss3Q3ukzfq5MznX+bmygw
	IsoHMqLuQykbI5nhERGujlHqAW7J2QxMLpkbNNOZgFw+v8AkRXlUDeLA
X-Gm-Gg: Acq92OHepsFSz0/0Ikjy/NFwo6TB+yjrW7zD0lpm9YFXv7uOhYFTkZoM5b76XwicSem
	LkPIIEa8tNqaSDgI/gAClO+rnGUFKIvP2zuaRfOtLNifrPTvSOr27jJN4LhPjU7croYYKwPYFqD
	BgV2WE5yj8xth1eW1cuB4/9SM1uVVWNOqfvwKYWMqvhUC+Q7Cf3iot1q9ZFQiAs23nt4SahbHEe
	p92//e/jd5d1aG3kj02yJfoVe1d6d7VRdTIuQDeVChmgZRFYpZBwIiOHhHHx2CBXJZSsmxhfW/H
	SPnoiC5XVAt//B48uv0/VfLZKgg2o9K899MJBk1rNPQJnUz2LQZ02PQ5O+aEvym4JsRHVGb9lLz
	YMOabdwHofaUQ//q/0G/11xg0FCQpBDvoVv+KFGjip0B6KGwREVkEU/DtjeTzIpqFROMj0F2DKS
	oot43OT6jwqWUTHlw3DhV6lqGvfGeohYkkdmuPn+LhheXwzBtqrkmRjofAvae62KnNEjuy9Dqbf
	b98
X-Received: by 2002:a05:600c:45d1:b0:488:7ff6:1f75 with SMTP id 5b1f17b1804b1-490c262226fmr272947745e9.21.1780948939364;
        Mon, 08 Jun 2026 13:02:19 -0700 (PDT)
Received: from machine (host-176-37-220-32.b025.la.net.ua. [176.37.220.32])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3d66c8sm397939805e9.10.2026.06.08.13.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 13:02:18 -0700 (PDT)
From: d3z <d3z.the.dev@gmail.com>
To: even.xu@intel.com,
	xinpeng.sun@intel.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: "Danny D ." <d3z.the.dev@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	abhishektamboli9@gmail.com,
	sakari.ailus@linux.intel.com
Subject: Re: [PATCH v2] HID: intel-thc-hid: intel-quickspi: reset touch IC on system resume
Date: Mon,  8 Jun 2026 23:02:07 +0300
Message-ID: <20260608200209.46974-1-d3z.the.dev@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <IA1PR11MB6098E927297E716FA72FDD04F41C2@IA1PR11MB6098.namprd11.prod.outlook.com>
References: <20260529222210.1532876-1-d3z.the.dev@gmail.com> <IA1PR11MB60987CB2D72FD1701951DFA4F4152@IA1PR11MB6098.namprd11.prod.outlook.com> <IA1PR11MB60985B856D77963E2DBE47F9F4152@IA1PR11MB6098.namprd11.prod.outlook.com> <20260601213047.115271-1-d3z.the.dev@gmail.com> <IA1PR11MB60985A7B3D9EA4583C2DDBF7F4122@IA1PR11MB6098.namprd11.prod.outlook.com> <20260602151317.27768-1-d3z.the.dev@gmail.com> <IA1PR11MB60989CC8623B35747E0EFF7EF4132@IA1PR11MB6098.namprd11.prod.outlook.com> <20260604202647.16777-1-d3z.the.dev@gmail.com> <IA1PR11MB6098EABFE876D4D6197443B6F41C2@IA1PR11MB6098.namprd11.prod.outlook.com> <IA1PR11MB6098E927297E716FA72FDD04F41C2@IA1PR11MB6098.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Danny D. <d3z.the.dev@gmail.com>

Hi Even,

Thanks for the review, and for working through this together.

Danny
