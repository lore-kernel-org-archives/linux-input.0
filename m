Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B574626738D;
	Thu, 23 Apr 2026 15:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776958390; cv=none; b=j4kGJbaMulf8JF/5Cc9rbIlTpGm7SqO32SeLUOXm+mbglmKiDddLAjppecRzK0TGsU2xA8oRWa1/Kt+txkiFlMdSPj2Hc8LsrTsxqORoldK1qF7S9iTvTjPxsi6+jPL5LnvTsA65CxCQy5wgM7iyhW7+phb2g+lw/7UzvQZq/Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776958390; c=relaxed/simple;
	bh=zl8V6kn1Lc8xOCXTfPiZLE6+KvRSC7osqFwwoHOvRmU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=VtreaUEjyuHTpdQ+eyMJHCZg2gXFkv6Zy+c+BF4MOL3wSLgJp+Kams6tRYp7CdmXe1ZVBNXDWWw/vBS6tMnr/dqB8MGOCZSAk96epxaIrULeVFGs7UbXHbsl/QUPI1ZiFaZrgQv4dgvnqX6oWqc41xxTrCO0zPpc1UF4Z62ZAfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=YuhsOlOW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TyvjoVj7; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="YuhsOlOW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TyvjoVj7"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 10AC4EC010C;
	Thu, 23 Apr 2026 11:33:08 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-02.internal (MEProxy); Thu, 23 Apr 2026 11:33:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1776958388;
	 x=1777044788; bh=vKWRAzMsfgiM8A0XI0KdYaNaqCsRUluseaNlxe9y/TI=; b=
	YuhsOlOWn4Zr5d8IM0pLe8Ltc56r7pmDZToJXI1DWsJPPr9eZbIbsYpnNCS/MhKS
	/yggTKvkaP24yQsjgCkU3wUaci3hyPfhtrtIPD7fWIZifj0dodjKVYfu/YrfMjVr
	YPOq5FbZ7MXhFzYsox2hv2jlbsgZGZgJXN9+33/V8xfBfqysE9xkXrt3kEs4Yrs5
	P5TSPZ/cohL3a/BICZjHJbXMvUa/SXw068P3OeUwdQIrI3EdY7nsTLUFA9mofFaw
	T2HYSj4As3gqcB9xUPh1a2ZBPoZ0UQ/Tkxv26zdDH4/s+zQVUSMbblYQWW7tSc/N
	0JrfOVX0ExtGs1BilMhwVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776958388; x=
	1777044788; bh=vKWRAzMsfgiM8A0XI0KdYaNaqCsRUluseaNlxe9y/TI=; b=T
	yvjoVj7QdrtRnIowntfupV4wErv+ZRDlmv/ME515vUITspELnvuD0QuxiJFtNHzl
	QYICQuPrPuTm4YXA0qUIAsCgAj7WJqyZDlb6ljD6LLehF1IsLLr3wKAe6cMUATsC
	iTgTk2Kafnhqijr9hO7Tt+Q/yXFk4O809G+zqdSLuITJlkBPKL/sMzqkcVnEHlxp
	8N4bV1Fb+yqT3bjTFFjjZaIltDE8npqKK0C9+agyDNgMIUx/5NCbqAO+IqzPGPJG
	N3BuQtkRjhxx5xnfHKg+BQPPkI3pCBTblgaB35eweRopQaZBcJLY0JKPeByzTfPt
	tvzAn1n/rx7HkMUtQDKuw==
X-ME-Sender: <xms:szvqaRjjfQv9BtxwrdmMEDQKSoAtIT0JHDf2YTVJwHlFnJBVrii97Q>
    <xme:szvqaQ0VUAR0vAfMqyXXvENw925hp3xFBe78uKAf6LhbUW_z_b4zY3WcSN3iNWi0z
    iTkp1YxxoT3mCMU62vwNTxKx8JJheRVzbuZPVpnHtR4jad5E-qD8mGe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeijeehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdforghrkhcu
    rfgvrghrshhonhdfuceomhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrg
    eqnecuggftrfgrthhtvghrnhephfeuvdehteeghedthedtveehuddvjeejgffgieejvdeg
    kefhfeelheekhedvffehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepmhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrgdpnhgs
    pghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvghrrhhorh
    dvjeesghhmrghilhdrtghomhdprhgtphhtthhopegvvhgvnhdrgihusehinhhtvghlrdgt
    ohhmpdhrtghpthhtohepgihinhhpvghnghdrshhunhesihhnthgvlhdrtghomhdprhgtph
    htthhopegsvghnthhishhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjihhkohhs
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrhhinhhivhgrshdrphgrnhgurhhuvh
    gruggrsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepkhgvrhhnvghlqdhj
    rghnihhtohhrshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuh
    igqdhinhhpuhhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhu
    gidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:szvqadDe2LglufdFKgQHWJwv7SKq14maUMuYHw7LtBROPNBNniLQfQ>
    <xmx:szvqaem_uoTjCewliIFlaUBauLKS_bv9QasuHU21QnJhnztG15Kbjg>
    <xmx:szvqaTPk2KAl-0ysd6Sru8xATwlkbs-jF91IcUovthiBcRUP6hj9DA>
    <xmx:szvqaT9zZcumMBgg_hzPSxDfkKwE6jWOyOQ3obxzYxOVWLaSkkVUSw>
    <xmx:tDvqaUQWQF-sCddbedG-562sJVeM8ZgOq5UyQj-u4GoucmJl3cT2HcJs>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A8CFA2CE3F94; Thu, 23 Apr 2026 11:33:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AywJIOr1D2cJ
Date: Thu, 23 Apr 2026 11:32:47 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Dan Carpenter" <error27@gmail.com>
Cc: "Even Xu" <even.xu@intel.com>, "Xinpeng Sun" <xinpeng.sun@intel.com>,
 "Jiri Kosina" <jikos@kernel.org>, "Benjamin Tissoires" <bentiss@kernel.org>,
 "Srinivas Pandruvada" <srinivas.pandruvada@linux.intel.com>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Message-Id: <6ac4045e-1c9e-437d-8efe-0bae43d00699@app.fastmail.com>
In-Reply-To: <aeo25zL_XIoFZ7uK@stanley.mountain>
References: <aenFyk36rTnrD9s3@stanley.mountain>
 <7e6c43e6-7896-4504-bc13-5f12025596b1@app.fastmail.com>
 <aeo25zL_XIoFZ7uK@stanley.mountain>
Subject: Re: [PATCH] HID: intel-thc-hid: Intel-quickspi: Fix some error codes
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


On Thu, Apr 23, 2026, at 11:12 AM, Dan Carpenter wrote:
> On Thu, Apr 23, 2026 at 10:51:10AM -0400, Mark Pearson wrote:
>> Hi Dan,
>> 
>> On Thu, Apr 23, 2026, at 3:10 AM, Dan Carpenter wrote:
>> >  		dev_err_once(qsdev->dev, "RESET_RESPONSE body expected len = %u, 
>> > actual = %u\n",
>> >  			     read_len, actual_read_len);
>> > -		return ret;
>> > +		return ret ?: -EINVAL;
>> >  	}
>> > 
>> >  	input_rep_type = FIELD_GET(HIDSPI_IN_REP_BDY_HDR_REP_TYPE, reset_response);
>> > -- 
>> > 2.53.0
>> 
>> I think this would be throwing away other possible different return values from thc_tic_pio_read?
>> You'd be losing the -EINTR,-EBUSY, -ETIMEDOUT conditions that might be useful to the upper layers.
>> 
>> Should that block be split into two separate error conditions?
>
> It doesn't throw away any error codes.  Writing "return ret ?: -EINVAL;"
> is a short hand for "return ret ? ret : -EINVAL;".
>
Yeah, you're right - read it to fast. Sorry!

Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
