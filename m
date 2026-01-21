Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38A426E70E
	for <linux-input@vger.kernel.org>; Wed, 21 Jan 2026 00:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768955749; cv=none; b=eV0kHgjt4hEKUb0+bkq30ONMdX67PBT8GvUwOKFLKNUp4LUTUdRD/TVcbMb/UGVIYOipZj/jOmvD4AQ06dgiUBTkVaq2J3x48GNniG0UPVhTUnn9dg0g2Ul624Vj0AL7SraP9bQ7B5QfLjeeQBA1k8yVW2YbQ2KxrOTPJ+pxHQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768955749; c=relaxed/simple;
	bh=2xSN1Apzt56p/AWtH6rnMmSTf2L9kD/BaBYIBIkigRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kUi0g/W2pvs5fPFU+oYXCTEMAHlgbk0JMDAYlnVVk0mKbr4PkNgYJJcTE9kLf6P3BrxLaWs7KnUms/+7C0XRmNh7CUZ1WgjA/nnt9I19lmaCT6MmGSMZg0CwJ8v83vjeIF+Q3lrZx6H87Qxdj7TZ+W1BvZUG1ynGNbU1LGuebCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mbWbzCXb; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mbWbzCXb"
Message-ID: <1dc18b13-af48-47d4-afdc-35b31410eea8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768955735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5TOAcadMIxZOzVHez9+5jxvHs8dEnxVWjw5XqasR9gA=;
	b=mbWbzCXb6KLarcffurdhoVtHj1iSNnOHf43F6tdRehm3hbwIToxfeD5VMfgBc5iDCE8JTM
	38FuRXQikBiut31kLO446Z1PZonjXAeL6oc5w3UfBTD6hcvFWY7rZ7LrYjWPICoGCWJPjL
	XCVpYxr+YWHGIuVGSoRequX0bvmk9XU=
Date: Tue, 20 Jan 2026 16:35:26 -0800
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 03/13] bpf: Verifier support for
 KF_IMPLICIT_ARGS
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>,
 Tejun Heo <tj@kernel.org>, Alan Maguire <alan.maguire@oracle.com>,
 Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 Amery Hung <ameryhung@gmail.com>, bpf <bpf@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
 sched-ext@lists.linux.dev
References: <20260120222638.3976562-1-ihor.solodrai@linux.dev>
 <20260120222638.3976562-4-ihor.solodrai@linux.dev>
 <CAADnVQKtN9HS7sWE_fZex4hT=ZEGDQX+C7tS6jc2+8ixC+Jexw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAADnVQKtN9HS7sWE_fZex4hT=ZEGDQX+C7tS6jc2+8ixC+Jexw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 1/20/26 4:30 PM, Alexei Starovoitov wrote:
> On Tue, Jan 20, 2026 at 2:27 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>
>> Introduction of KF_IMPLICIT_ARGS revealed an issue with zero-extension
>> tracking, because an explicit rX = 0 in place of the verifier-supplied
>> argument is now absent if the arg is implicit (the BPF prog doesn't
>> pass a dummy NULL anymore). To mitigate this, reset the subreg_def of
>> all caller saved registers in check_kfunc_call() [1].
>>
>> [1] https://lore.kernel.org/bpf/b4a760ef828d40dac7ea6074d39452bb0dc82caa.camel@gmail.com/
> 
> ...
> 
>> -       for (i = 0; i < CALLER_SAVED_REGS; i++)
>> -               mark_reg_not_init(env, regs, caller_saved[i]);
>> +       for (i = 0; i < CALLER_SAVED_REGS; i++) {
>> +               u32 regno = caller_saved[i];
>> +
>> +               mark_reg_not_init(env, regs, regno);
>> +               regs[regno].subreg_def = DEF_NOT_SUBREG;
>> +       }
> 
> I'm reading that no follow up is necessary anymore and
> the new selftests cover this part automatically.

With respect to this series, the hunk above is good enough.

But we haven't tracked down why doing

	.subreg_def = DEF_NOT_SUBREG

inside mark_reg_not_init() breaks zero-extension tracking.

May be a dormant bug somewhere.
