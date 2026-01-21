Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B67F387359;
	Wed, 21 Jan 2026 16:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769013896; cv=none; b=gpL2my8TWKnO0Uj91hEmydCRqXUO5ao02b4+M4xeZD4yv19LtRQ3qY3mDzPRxwAizEIs/CJDTpvSqf0hAgEAJLGSXn2omTRt/kjd6deprogOaGcX0plPthw9xYYczXCBQalVVBz5dAQsp9wPA+E+fWfBlR1MOc7BHUIKwvbOdXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769013896; c=relaxed/simple;
	bh=gpy39E4hjExdiGI8hoV+/whzbphV0KEEy1L/pN0p4Ro=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=vAn2Db367nO/yS+bedRlFsbcSxi3umoimFByCwPEULi7SLDd0yqUAJArDKJGX7H0Xw+oVLOWd5ve0wAtqCHu5n7j7mNhjyn8fROgwPHTxo1thH++zcYeM1AZ8s+lfqs/r/KcpDqNkAlnZJPY7AUbk9ubuR4j4U1XpmiU24dhr6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=V+aWKzPD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ScjgWL0x; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="V+aWKzPD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ScjgWL0x"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9360814000FB;
	Wed, 21 Jan 2026 11:44:53 -0500 (EST)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-02.internal (MEProxy); Wed, 21 Jan 2026 11:44:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1769013893;
	 x=1769100293; bh=Nj5/2K0y8F3SObmsit1lEGB/hc4bvHGQoc7CPAnK3nk=; b=
	V+aWKzPDKqSCZBkv9OdS3Ihg7wa8xEAk35TeWVixmWPUkIzyrj+p8/DCeipwoxiW
	cbGK4nuT79ENME9djN61ybmHbsg6aavf7Y9/yqubPGeA7P6KBM6VgI8ELWIP2OCA
	YGCPrJCcIwWc8R1AxOLjAKxNZwIZm/lZEQ17UE2vF57VMJuovhXn90I/ikqyQv9w
	2EyaFZdXHyvmzBU7QtRTInQP4Vco597olMmcvrnSUnhEBcsMAZh8q1fLwpdEqfIp
	3lJb9G1dIS/+yXdhEVIgPORWXmDgfoNd2xorkNGRIDpJ68A2UX5QiwsojQwgXdxh
	C8d8hR3mLUhZ2+gxgCPyow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1769013893; x=
	1769100293; bh=Nj5/2K0y8F3SObmsit1lEGB/hc4bvHGQoc7CPAnK3nk=; b=S
	cjgWL0xS3RS9o6mpmsy2fcJMlfZIZbrJ7+cTEbmw9qhTnIV/Iv3iZwD+hGzcOVYN
	4+i/qoReyJO1FvPKitHLXU7VnJ4MwjC/SVYfRHmifZbVd4/HwmwurcedN7byqWFM
	gnmgS+V7Io48F/bwrknyGMtLeUfJRegkZ+6K52PUX624d5Y9QWMNtnzgCRUP5bwq
	AoFwMY86ieSChESeFUc9q99kK+fj8Sux7/D/7pQXwZn3aNsrL5VHoy0gw4uQsqB/
	Ajlv2XYCX06UuMdT7xN+kB2fUwsenJ/bgdjxfkbWRLInr6xU1v1C4vbcniTt2lN3
	lOlBxw2Cx5LkZVlb8K1yg==
X-ME-Sender: <xms:hQJxafQL-hd_dAFYEuK0DE08D4mLTYoyhRO-vQfyO5Bkh6VYpw0wJQ>
    <xme:hQJxabkis1RoEpC2y2vpqak4-E02HX9uK1jQmOHk65rcuUFG-XNmPGuDkIi3yeAml
    zkDlapkaydIj-vGxgie6M34Watg9rTHXoqnaNiJiyXf32g0B9zttg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeefjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfofgrrhhk
    ucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtg
    grqeenucggtffrrghtthgvrhhnpefhuedvheetgeehtdehtdevheduvdejjefggfeijedv
    geekhfefleehkeehvdffheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrpdhn
    sggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgrrh
    hiohdrlhhimhhonhgtihgvlhhlohesrghmugdrtghomhdprhgtphhtthhopeguvghrvghk
    jhhohhhnrdgtlhgrrhhksehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhhtihhssh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhikhhosheskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepshhhrghohhiiudeslhgvnhhovhhordgtohhmpdhrtghpthhtohepii
    hhrghnghiigiefieeslhgvnhhovhhordgtohhmpdhrtghpthhtohepphhgrhhifhhfrghi
    shesvhgrlhhvvghsohhfthifrghrvgdrtghomhdprhgtphhtthhopehlihhnuhigqdguoh
    gtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqihhnphhu
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:hQJxaW1ru2p1fQ1t7q3wVJoLutvriqPy6NNjaZOZCy-unzvb7EOoog>
    <xmx:hQJxaRS8PiXMTp5orrsOqZ2UIkdnWgVpaM_IKK-yYezFDZgi_k6rJA>
    <xmx:hQJxaafOmnxKdbaeCt6F5O7OSJJFL_bOm_Amtz8fx7YYn9oD4ga_zw>
    <xmx:hQJxaSeNANqF-Y2eeQOh3X3llDl3q0CqrqPhRD5OhColoZWXInONdQ>
    <xmx:hQJxacpUZjiDIiQjpdAqJaKNHDYx-RlPIFZNJiT26C-Q6VJa9gXEIIls>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1E9422CE0078; Wed, 21 Jan 2026 11:44:53 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AC9rIZzNZkww
Date: Wed, 21 Jan 2026 11:44:27 -0500
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Derek J . Clark" <derekjohn.clark@gmail.com>,
 "Jiri Kosina" <jikos@kernel.org>
Cc: "Benjamin Tissoires" <bentiss@kernel.org>,
 "Limonciello, Mario" <mario.limonciello@amd.com>,
 "Zhixin Zhang" <zhangzx36@lenovo.com>, "Mia Shao" <shaohz1@lenovo.com>,
 "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
 linux-input@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <5f285fb4-8946-45aa-8b08-9dc7f0ab1170@app.fastmail.com>
In-Reply-To: <8693204A-60AF-48CF-B453-446ABADDA46C@gmail.com>
References: <20251229031753.581664-1-derekjohn.clark@gmail.com>
 <20251229031753.581664-3-derekjohn.clark@gmail.com>
 <0on4p9s6-7512-9408-49no-3292o86113r3@xreary.bet>
 <6BB4F74A-F440-4F21-B094-62CFD18C599A@gmail.com>
 <2910bb2e-6b31-42f3-a3de-463327b16ff1@app.fastmail.com>
 <24on5sn2-2726-84q2-635q-9245n343qqrp@xreary.bet>
 <8693204A-60AF-48CF-B453-446ABADDA46C@gmail.com>
Subject: Re: [PATCH v2 02/16] HID: hid-lenovo-go: Add Lenovo Legion Go Series HID
 Driver
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Jan 21, 2026, at 8:16 AM, Derek J. Clark wrote:
> On January 21, 2026 1:08:18 AM PST, Jiri Kosina <jikos@kernel.org> wrote:
>>On Mon, 12 Jan 2026, Mark Pearson wrote:
>>
>>> >>I am now almost finished with reviewing this pile and am planning to queue 
>>> >>it in hid.git shortly, but I have a question regarding the MAINTAINERS 
>>> >>entry above.
>>> >>
>>> >>The title claims support for all of Lenovo HID, but there is much more to 
>>> >>it than drivers/hid/hid-lenovo-go.c, specifically in hid-lenovo.c.
>>> >>
>>> >>So either please make the title more specific (or claim the ownership of 
>>> >>the whole Lenovo HID landscape indeed, fine by me, but the please reflect 
>>> >>that in F: :) ).
>>> >>
>>> >>Thanks,
>>> >>
>>> >
>>> > Hi Jiri
>>> >
>>> > Sure, I've debated using LENOVO LEGION GO HID drivers and LENOVO GO HID 
>>> > drivers. Do you have a preference? 
>>
>>Either works, as far as I am concerned.
>>
>>> > The other drivers are pretty old and I don't have any hardware that 
>>> > would use them so I'd prefer to keep them separate (though I'll 
>>> > acknowledge that they don't seem to have a MAINTAINERS entry)
>>> >
>>> I should probably take a better look at the lenovo-hid driver.
>>> 
>>> The platforms that it's supporting weren't in the Linux program, so it 
>>> never crossed my path before - but looking ahead I think we may need to 
>>> contribute some changes there (guessing a little, but I'll know in a few 
>>> months time).
>>> 
>>> Jiri - as that driver is targeted for Thinkpads, I'm OK to take some 
>>> responsibility for it if that is useful/helpful.
>>
>>Perfect, could you please then either send that as a followup patch, or 
>>even have it included right as part of Derek's series?
>>
>
> If Mark is okay with it I'll just add him and that driver to the same entry.
>
No problem for me. 
I always feel my reviews are limited, but I do try and read everything and help wherever I can.

Mark
