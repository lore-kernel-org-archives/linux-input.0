Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793094095;
	b=GZp1x2XD5Dk0l8e1xc9DshMX9yGlZDNmNTXHhaqTGAMcteFYr8N+J3tfbnziFv+PD+bs
	 vjHE4/KAo5yLwGrGX3dhwWAwRrPMJfu8vKP+nJVCFDk90U4/HJRoAHTRmcNDyGj4UYkV1
	 T/2uzY9ScFD9AsOWRQtOFHOLn0ICDBACCZAB36DUPsBzLy8KhTasaI08hWVu0j5H6/pki
	 cYRuJXaZmGMn3LJizeQam0YKuy97SRy8Xit7Xy3D4vIK1lV3T078yib+lm1whl8nk3ml/
	 U911HncNI6L0hrXMynCcW19a+3G+fkrIHtgM7NHLBv6mWnKrhab3y3eXPSKSNtuclWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793094095;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=UDSipwswQiKOFZETfFd0sP/sXqxajC2VdO9O8E2arqs=;
	b=aNRH906/dShRdE4WnRTWLqJ3ew5nG1grYYA2jqaouqrmqXBJmdhqIFNRFHLh6C+dXqfz
	 zzh6q52eMRaTo/BFp6OnZehj/w7KKyezuzFt+af1Oe0/qNzwVn59ozrnfDrPM8gRmvw8P
	 9ye8KnxNTumfzs5qgWvVco1pwPMcMOv+66bGoloBWBiMIIeYmEg2nDnRtVXIPzXE8+lsg
	 eVT5Wlrw7BxBexXRJpNrCBhxUEss0iivKuXo9TthWdPi1yasgunl8lNrTUb5vhzt8kfD3
	 AO3Wd+sefVjFDLwzW6vFAmoFgIrqgW+u6eRzMfGKvLsiUnhrZC59OLWPbQ5mMxdzGjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=A8J8lbBW;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B194606A31B
	for <linux-input@vger.kernel.org>; Tue, 27 Oct 2026 09:41:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B194606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=A8J8lbBW
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-36661f953e4so7193511eec.1
        for <linux-input@vger.kernel.org>; Tue, 27 Oct 2026 02:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793094089; x=1793698889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UDSipwswQiKOFZETfFd0sP/sXqxajC2VdO9O8E2arqs=;
        b=A8J8lbBWFpci3PVBaMCaWnW5Z+hQkw7snfrchHPOGAZXAsrJkFuyHLrU5uhLycHaLx
         2FK8TAA3hEU/4+CnI1/oON1dEZfa/TNTYleoytAZPjl66uMgDq+1Mj1B6uog+HJIns07
         hHf8LQ6C/l2hoAKOH+qZR4IeQ26/aaFxKELU4aGzcJzpT+705p0t7BL8HVq62FgBvxcK
         GrItPLBJp1K03l4O6ZCOTf0L+/fA/h4xkIQbtXh9mNzwWIaFUE1Sv40TASNr/0+6bp70
         bJcSEa+7mZXTljgsNVFkLrwUNVgzJguaviKD1MOVL14KOxJdIxjgu5In5cnK/qzC1YPA
         fgBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793094089; x=1793698889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UDSipwswQiKOFZETfFd0sP/sXqxajC2VdO9O8E2arqs=;
        b=YdOLVpjKynRbzdMgo6E11dnr3Yy7Nxpd4jgGKxVCAjxtFf87bV6AN7KxkLw72TeNnM
         ulMFVJJDnsH9FePXG0Lf6A6Rr1eZGfT20LETvrty3O8Bw+7m60grF94VG1i4byFDuzHP
         t8kBCueIlhDJa3n83WQoqHaNrlAgGr9uelTI3ztOG8cVX5owbU6AIk47ihCWTXcXDVya
         7IT2PWjXHF4XQM2lQfBCY8mIyHlgIBq4DKnObOEqJcfIyqLcDF+4i/EG0RIQ8oY6V0YV
         zrWUPm7MHkQgN68BF1YoXkxzBLODwAIeCgDyub9lYwlTH8MCvjvI++jbzSzKBJF32nS+
         y6JQ==
X-Forwarded-Encrypted: i=1; AKwUvBzL46OcTqBLiGW85kVDbSHRWelWOKO0+fSXzfwCuskc4vcnVxGR6JlBQ/1ibGGTXPbrfYaNDJwDLpL3Vg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJfvho0OOXI+AVGLI7nqj7nUsGmccw3PUJejDSA/ixAkUpDyd3F
	ZXOQ5NChOe2f5O+hDvlaDrBYp6EEwQLs94Bar+eUeTpvW0s//CC63U5K
X-Gm-Gg: AYBFou1/dnCAqnmUeBMmX4wjDMGKX6IVYCcWCJwjFoOO2EjWXHeercilBZtaN+UPIea
	G0JzmeGbXkupZxTlMz5OYDj2rgOz65nyGGL/utnkqGkrbKi6mT4qV9OJUdPLcfb/TIBQNrqZNdM
	ry3DlRsUcr0Mjk1hshCDM2Ra0CGPVcSaHCNakLebmu1OFtHpoFPg3WvAwMvCLOEAD1JkDvudDxw
	iFwkRYkkvsguH4gtfjsBdB5wI4iCLL98d3Vqnd+fXuGj3YNw2Pdg2iccrGEwG01asjwi6te5rsM
	TlrvQHPgbW9lrsNHYuyailXQeWuPoIGGs2w83q36ULQ2LVZ8IZfxrmJ3nDc09jru4mBfgdAki+o
	EmViR1+LLRMabWdmaz0ut1hvMfY7KA9MLnZ9t0t+MtZJW3ap6TtW/8ZBz+peMhzCna7DKGyp1j4
	6l/wamMixwxkclmPDKrALuXEohaI4G5+s0ncpOtkHXUporB6urjQYNbqtO1vJ5jcL1OidFCeZAv
	QhuQ6CP08UrCrk6NQXBLPZKmSANWk9fQpW7IKR2K7OdfMTXNTl5p+U9C3xcJCnu4Kg+u3gULipB
	DplXOYv0YBIeZWD9Uei9zoLhmplDQDo1aBY+0CADwSVwpr8b7jFZdcNM8cVCbpEAf7npI/9yY4M
	9ppGNXm/ZHPuy
X-Received: by 2002:a05:693c:87d7:10b0:366:83dd:46f7 with SMTP id 5a478bee46e88-369e84bc5bemr13599484eec.17.1793094088758;
        Tue, 27 Oct 2026 02:41:28 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8ec50bcsm60208024eec.23.2026.10.27.02.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 02:41:28 -0700 (PDT)
From: HyeongJun An <sammiee5311@gmail.com>
To: even.xu@intel.com
Cc: jikos@kernel.org,
	bentiss@kernel.org,
	srinivas.pandruvada@linux.intel.com,
	rui1.zhang@intel.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] HID: intel-thc-hid: intel-quickspi: validate GET REPORT response size
Date: Tue, 27 Oct 2026 18:41:24 +0900
Message-ID: <20261027094124.223069-1-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027025820.3085067-1-even.xu@intel.com>
References: <20261027025820.3085067-1-even.xu@intel.com>
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

Hello Even,

Thank you for picking this up, and thanks to Rui for testing it.

On Tue, Oct 27, 2026 at 10:58:20AM +0800, Even Xu wrote:
> -		qsdev->report_len = sizeof(body_hdr->content_id) + input_len;
> +		report_len = sizeof(body_hdr->content_id) + input_len;
> +		if (report_len > qsdev->report_buf_size) {

One question about this bound. The DATA case accepts a content_len up
to max_input_len, and the GET response adds the content ID on top of
that. A GET_FEATURE or GET_INPUT_REPORT response of the same size then
gives report_len = max_input_len + 1, which this version rejects when
max_input_len is the larger of the two lengths. v1 compared against the
allocation, which has the output report header to spare.

Can a response that large happen? If it can, comparing input_len would
keep the same limit as the DATA case:

	if (input_len > qsdev->report_buf_size) {

Best regards,
HyeongJun
