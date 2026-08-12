Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A2B3314AE
	for <linux-input@vger.kernel.org>; Wed, 12 Aug 2026 07:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786518235; cv=none; b=ffVfiuYq5FQlrQZ7GsM1CfP0/4Hjrp1XCm1peASqgPgB48J15YBECRuXwBbawoGuTV41Ul5R6Fr43U3HTuvfY7AMSbayLMarTI5EsHAtGciktWfbLW8p3eCTIrXEBUBmNi9IfM7b19PPbAtgRsspDq8jY8/sLbR8SFuCRhW+c8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786518235; c=relaxed/simple;
	bh=GCkBXddSbeHCDvY1GzromperE2nmzYP3jL1SLw1+JJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=azXdffrnmPsinAyuJnhrv0GMpTbxDDFm6yg4g5U/n75jv5gbJQjsb9Ik3d4WnOH7IA4lztpTw6Kw9gN/Qrolj5Wc8yUVDvpT5MbmFis3eR22WzNtRD0vHiwRdhl66ey6/VBj3VFHHFARb4mSRC2ESyW01d97tv1jCSxQjWSvUe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TEDsBPfX; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ev1dWeJD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TEDsBPfX";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ev1dWeJD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786518232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GMSQFwJ3Pn8MGM6lOdOzrV1KHdix97IWR2KeUG/GEeU=;
	b=TEDsBPfXa+ttk60AGY0FSuDnFFRrP3MPl4+nXfbomETMpF2Kdv57i33cIB0G3KK7YKmKHa
	/KL1nTES+wh/lKeJxm0OfQZLncfmw19Tz19Muz9J1k9CRRxAUMo2et7HMtTx9Blot7ogm1
	OoMHsFAYxmTRqYckIx1puHt4bUNSOo0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-C7gX9ofrN3eFTWToZemF7A-1; Wed, 12 Aug 2026 03:03:51 -0400
X-MC-Unique: C7gX9ofrN3eFTWToZemF7A-1
X-Mimecast-MFC-AGG-ID: C7gX9ofrN3eFTWToZemF7A_1786518230
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4996832e7b4so11750385e9.1
        for <linux-input@vger.kernel.org>; Wed, 12 Aug 2026 00:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786518230; x=1787123030; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GMSQFwJ3Pn8MGM6lOdOzrV1KHdix97IWR2KeUG/GEeU=;
        b=Ev1dWeJDxFoaQNmhLYJbp9fsbGub+dt+mEuTBmgw5FJw5eqynqKQW23zUK51Mn8H0h
         ckqLCQWkjx35JcE8pMug04kGM9hD4J65b2zorGV7GpkP0CSco7/R27sNzQ0S1pnX9jUB
         SudS4vZBWg/EtGmV7OOoeEHnxU+tFN5Spb3CqedePFrAnK7FTPk7ADnYRGxZoAyU0yH6
         JA1ZBugPcZEPuPVEElN78/G1fXcYhHdDg5sd6XP4LMfFScKKvHa+4iVks7YLQLwXUrPt
         muyMR6dwi8ditKDQAbAhcTupYAOIFQgYJ1v956xnLMGGl2EH5Vl83SDY3P6I7m8l2m2W
         sNzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786518230; x=1787123030;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GMSQFwJ3Pn8MGM6lOdOzrV1KHdix97IWR2KeUG/GEeU=;
        b=et67pbRzBBnXMH+8UUWBfHWdUwhaRho8MZ+REIFxZsZqOs/DsURMAu/fQmKMD6hf0B
         mXffU0yAHImTpdsNPhM6qCxgtAr+8f6wUPvNHuvmuebusWQ9p1uyjxjDHC962T0FwjmZ
         uF7R6FIl+3UBLWhzA0COzkAlLsVwIMx5lx23jAKgyzKMrauF9l9LqR55Jdqss9WfWfjP
         djxQVwhy7hfZQJK7/7MG7+udP2r/Ki/4xLnnQIz5NGogDBidcQRq+GqoUxNEqjqcPRTt
         JxTK4geG0/1iw3wA/C5NF6sQMhPAQgesHX1mVyKUg+M8/W3KjvO6FGjWf8kbtHP+ZAzc
         GQwg==
X-Forwarded-Encrypted: i=1; AHgh+Ro1k+oZ0jQVTtK4CwQ/FCl1zqEpuhqioC/p7eEAxKXi0X7dihHsbwNaiuXb/uJS/tEz2WmJSl/TusoQqQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBSetRKqqzYBhIuzqOqiglVqK6HzI1+VVDvUQvEa6KnIwcxpn7
	deZPT34nRvRr3JESQzPqxT+RKu7SWsPVuouskTSA6dS04sl/TjvSsdaLJsz8D2ixDO/4MtivwKh
	1+LuNw5iO26979JnJRI2+XVmHBvn7mBSQ+24GQH3uwojpVwSOWd0nWBKpQdNFjB0=
X-Gm-Gg: AR+sD12BbKKdeUykchjUeUh+SU0uuJdutZahv/uTbBrDEpv3apNc3X4MbUOwGQUEXfj
	7lB/4Z5ntUHO5ny4Wst+SkL5qQ58WS7qW+9WtR6aXymbBewquxKxlV3GZRHdSwm1uLPMl7M6A94
	VP6AwHOaXN0P26nVlo/C8u4x3LphmibL85niM4oFnWyWvvD3yWDUri+PHqnLNskI7sP3hEcQuFo
	Oa5X5a7phNkUQr3O+PuLbhKXMSJIQai9jNtBcBzgoR2Nt7q1bz6JlGwlgOJN19AaaC3mTfblbqL
	6XT0L/jNeQeqerxcix20m7TYlfjDclDhBUtc3UqzBIBvY88G9K2J+8FoIHGDmNJA8GBpJtQZLgk
	msoLWEiQ9vvEUSiR5ogRQ59KqBptZw8HDNVA=
X-Received: by 2002:a05:600c:138b:b0:495:5d6d:9cc1 with SMTP id 5b1f17b1804b1-4997c30b80fmr29456795e9.0.1786518229772;
        Wed, 12 Aug 2026 00:03:49 -0700 (PDT)
X-Received: by 2002:a05:600c:138b:b0:495:5d6d:9cc1 with SMTP id 5b1f17b1804b1-4997c30b80fmr29455945e9.0.1786518229435;
        Wed, 12 Aug 2026 00:03:49 -0700 (PDT)
Received: from [192.168.0.135] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997ada79a3sm46337885e9.1.2026.08.12.00.03.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 00:03:48 -0700 (PDT)
Message-ID: <02ce6b65-7670-4dac-ac9c-8875867d6ad3@redhat.com>
Date: Wed, 12 Aug 2026 09:03:47 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] selftests: add shared lib.bpf.mk to build BPF
 progs and skeletons
To: Ziyang Men <ziyang.meme@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>, David Vernet <void@manifault.com>,
 Eduard Zingerman <eddyz87@gmail.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>, Michal Hocko <mhocko@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, JP Kobryn
 <inwardvessel@gmail.com>, Mykola Lysenko <mykolal@meta.com>,
 Nathan Chancellor <nathan@kernel.org>, linux-kselftest@vger.kernel.org,
 cgroups@vger.kernel.org, linux-input@vger.kernel.org,
 sched-ext@lists.linux.dev, linux-mm@kvack.org, kernel-team@meta.com,
 bpf@vger.kernel.org, llvm@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260721174833.1232771-1-ziyang.meme@gmail.com>
 <20260721174833.1232771-2-ziyang.meme@gmail.com>
 <f2a0db3b-ac66-4b29-9dff-a691d9464123@redhat.com>
 <anTlFSsr5FqQt+o8@devvm16600.scu0.facebook.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <anTlFSsr5FqQt+o8@devvm16600.scu0.facebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/6/26 21:48, Ziyang Men wrote:
> On Wed, Jul 22, 2026 at 08:50:06AM +0200, Viktor Malik wrote:

[...]

> Hi Viktor, 
> 
> Thanks for your suggestions!
>>
>> Looking at the same line in tools/testing/selftests/bpf/Makefile:
>>
>>            EXTRA_CFLAGS='-g $(OPT_FLAGS) $(SAN_CFLAGS) $(EXTRA_CFLAGS)' \
>>
>> is there a reason why this is not respected and -O0 and -fPIC are
>> hard-coded?
> Yes it is true that there is no good reason. I will fix it in the next version.
> 
>> What if someone wants to build selftests (including libbpf)
>> with -O2 and some additional flags?
> I will add a flag such as OPT_FLAGS ?= $(if $(RELEASE),-O2,O0), which follows
> the pattern in the bpf/Makefile:37. So if we run 
> $ make -> -g -O0 -fPIC (taget libbpf) and -g -O0 (host bpftool)
> $ make RELEASE=1 -> -g -O2 -fPIC (taget libbpf) and -g -O2 (host bpftool)
> 
>> Is that possible with the new
>> lib.bpf.mk? It would be nice if it used at least EXTRA_CFLAGS or
>> USERCFLAGS defined in lib.mk.
> Good idea. I will add the EXTRA_CFLAGS for target libbpf, host libbpf and host
> bpgtool. Such that: 
> $ make OPT_FLAGS=-O2 EXTRA_CFLAGS=-DFOO -> -g -O2 -fPIC -DFOO (for target
> libbpf) and -g -O2 -DFOO (for host bpftool)

I'm wondering if we could use USERCFLAGS (and USERLDFLAGS) instead.
These seem to be the preferred way for all selftests, per
tools/testing/selftests/lib.mk:

    # Enables to extend CFLAGS and LDFLAGS from command line, e.g.
    # make USERCFLAGS=-Werror USERLDFLAGS=-static
    CFLAGS += $(USERCFLAGS)
    LDFLAGS += $(USERLDFLAGS)

At the time I was adding the extra flags to libbpf/bpftool sub-makes, I
wasn't aware of USER*FLAGS so I used EXTRA_*FLAGS instead. But now, when
someone wants to build multiple selftest collections with extra flags,
they need to define both. For instance, building with PIE requires:

    make -C tools/testing/selftests TARGETS="bpf ..." \
        USERCFLAGS=-fpie EXTRA_CFLAGS=-fpie \
        USERLDFLAGS=-pie EXTRA_LDFLAGS=-pie \

Switching to USER*FLAGS for bpf selftests would simplify things a bit.

Viktor

> 
>>
>> Same questions would apply to other rules for libbpf and bpftool below.
> I would check it them as as well in next version.
> 
>> Thanks!
>> Viktor
>>
>>
> Thanks for your time and reviewing. Please let me know your concerns. Thanks!
> 
> Best,
> Ziyang

