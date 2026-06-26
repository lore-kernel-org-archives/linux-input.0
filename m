Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB261714AA
	for <linux-input@vger.kernel.org>; Fri, 26 Jun 2026 05:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782451178; cv=none; b=po4KpKTpi4VuMSMpz1cx19cx29lz+6FE3JpXJ5RFkF0TSqduVmn0vDPM9IiBtDNHgI3QJuRn8bJX+DGw3mVw6HFxKF8eCJ55zDauc01ww66ILsmYHxKzaP6RVvTIT5WBKqCAbSGDBr0uMxxcftZc59lpulJjHL7lVBXO3BXe7z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782451178; c=relaxed/simple;
	bh=fjX+6PKZbEGQe4zBIUeSRPpDgQhExGE8q44AIsr7eSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QlEOHIgNxINNbxIMmsxdX6LYUirjujnUTHFvlOZtLSzPGkcB3qG7G4txtyh69n1UwR+s2kN0muBn8zN+YhR+DMSLMGlVHiTxfeOBIwA3bsdnwDm/IQwLHzoOmMZQiKhUogjUDmlLFL8DcE8mIuQmc5B0ZaIGGerRicjI3ItUlg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h+ZhetWp; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+ZhetWp"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-30c99ccb1afso536714eec.1
        for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 22:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782451176; x=1783055976; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SdScOQCXOlxsY/yjU2HQjsDMpCPXtWr4gDrycqlxMnk=;
        b=h+ZhetWpDl1TZYRsC45UdMlrEUQc3k8qKCwsFx10pHY30lL+ZPUUbq+9dBIhsgAz+i
         mNPOedSY8ekqjC6EDP/AvJ5c73Qb4Dez5Bax8G2nC+o+QWJjocJIIKG6MyU229GxaczI
         Cv9IRWrq4ND7Nsk4r2saX2kSQviJd2qEX39V/2SKtlgJY8NXqnS1BluBbwmaei7jySBn
         ReOiKuaDuQ4XmtGRdubOxeF6XFXHHp+gZNW55co42ukzJvjOT5TeeqKjqBXcpKfVGfpD
         43o5A0KlefVoD6ehJE3jbJNmrUXOIPk2EXw6VMBDKkGWopCIcUqO4lJo4lSnvV5gcNUY
         PcDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782451176; x=1783055976;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SdScOQCXOlxsY/yjU2HQjsDMpCPXtWr4gDrycqlxMnk=;
        b=QWw5JFjhfJOn0/VLCSP7bn1HVaBT2Pg/i9SRSUwcywr+wzpMZXehT8GM3+zw5XnqI+
         5pi3DyueZrZGBvKPkAleLxZ/lSd2CkD659iJgyXCXhp1nZQe/u64t5p/G8UlEU/UcMwA
         v+pqBg9PkQE+cwFRhtGkdzWjSW8MHpyoje0WKVeqHqGqj6Er9ajaUyOZ6Rf8humnISfy
         mdOXZnfynUhzCVUrhMi5gh3MxMhsezsTeVmUTF6404WkiKgdmqlfrttNo4t6bKdXvj8a
         17NCTrfwXEmLDYiOZEETap3CuaI/yw/zPk+jJDGbecKuYOFr3LdGJNgzOltThgBDl4r9
         cJ9A==
X-Gm-Message-State: AOJu0YyxmO7Grj0LviNkzZzhaT6TP87eb1fF+0vAKnZERIW9PTlmMOmc
	jTP4wcJQOLDkYU2i4sWXZHGWp/mNGCPjV/heE8TfqQFO+aN1bCcvtWXB
X-Gm-Gg: AfdE7clbq9lMIofrL5B9LRJBolze6F1LOHrNV/NsiV1Gxvpju7fXRdFbOQNEb33Mk4C
	9csyvvp9uWhKqgJrqRFdzqRWE2aXGCSO83DngtKKTtBdQSIKUbAtftCyTEMW5E2TYDO5a3scJ4S
	GbrWPqwzL3BSUusFQoZULCoPNiDcTWJE9gUnp5n8+lVvO5KgkLxQ5/8mrQx2JUC3ZAqcxbngIE0
	ld3UViLKLlOwFiW/BO7iMoV+OOsw+9JD8rIBjxND1eg7DhgDdpl8J11LqqJ77YQDNhpDOLrmc7E
	pN1R4FgFKyvtxp8q1qJmnh8ffRQW25v9a2aOGot7Mi1etrkZevdYIiLCkn22ahBLM74ywDS1ppC
	t+UuLSfCZ1OG6ROaazgtJ7+o0WGUv0oATa2Y1a+oq65DsUNvXkW+sJdq3derRyLNksKLBpJ+fzl
	FbnWAe1bGZAVx1LsHpvC/PZ6YEvBPA2VLGMjPutseFM7w3Mc5xXvUUAw==
X-Received: by 2002:a05:7300:2322:b0:30b:f6cd:fdca with SMTP id 5a478bee46e88-30c84f408d0mr6617805eec.17.1782451176472;
        Thu, 25 Jun 2026 22:19:36 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:a474:bf4a:4966:8d97])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c4ca240sm14343168eec.4.2026.06.25.22.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 22:19:34 -0700 (PDT)
Date: Thu, 25 Jun 2026 22:19:32 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: hexlabsecurity@proton.me
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Guenter Roeck <linux@roeck-us.net>, Benjamin Tissoires <bentiss@kernel.org>
Subject: Re: [PATCH] Input: synaptics-rmi4 - bound the F54 report size to the
 allocated buffer
Message-ID: <aj4LoEHHCMqUnyy2@google.com>
References: <20260613-b4-disp-6721686c-v1-1-4d5bb84ee520@proton.me>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260613-b4-disp-6721686c-v1-1-4d5bb84ee520@proton.me>

Hi Bryam,

On Sat, Jun 13, 2026 at 11:01:16PM -0500, Bryam Vargas via B4 Relay wrote:
> From: Bryam Vargas <hexlabsecurity@proton.me>
> 
> rmi_f54_work() reads a diagnostics report from the device into
> f54->report_data, sizing the transfer with rmi_f54_get_report_size():
> 
> 	report_size = rmi_f54_get_report_size(f54);
> 	...
> 	for (i = 0; i < report_size; i += F54_REPORT_DATA_SIZE) {
> 		int size = min(F54_REPORT_DATA_SIZE, report_size - i);
> 		...
> 		rmi_read_block(.., f54->report_data + i, size);
> 	}
> 
> report_data is allocated once at probe from F54's own electrode counts
> (array3_size(f54->num_tx_electrodes, f54->num_rx_electrodes, sizeof(u16))),
> but rmi_f54_get_report_size() computes the size from
> drv_data->num_*_electrodes when those are set, i.e. from the F55
> function's electrode counts. Both counts come straight from device
> queries (F54 and F55 each report up to 255 electrodes) and nothing
> constrains the F55 counts to the F54 ones.
> 
> A malicious or malfunctioning RMI4 device that reports larger F55
> electrode counts than its F54 counts makes report_size exceed the
> allocation, so the read loop writes past report_data (and the V4L2
> dequeue memcpy() then reads past it). On conforming hardware the F55
> configured electrodes are a subset of the F54 physical electrodes, so
> report_size never exceeds the buffer and well-behaved devices are
> unaffected.
> 
> Record the allocation size and reject a report that does not fit,
> mirroring the existing zero-size check.
> 
> Fixes: c762cc68b6a1 ("Input: synaptics-rmi4 - propagate correct number of rx and tx electrodes to F54")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>

Thanks for the patch. It makes sense, but there are more changes needed
in F54. I incorporated it in the series I just posted, would appreviate
if you could review it.

Thanks.

-- 
Dmitry
