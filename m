Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2341C372671;
	Fri,  6 Mar 2026 13:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772805120; cv=none; b=LWt3XKj3TRHWUt15YqWdWXG30CXEJQSt+aH0TkkHQIAmkEEPyyK7W9MgqmbksCLqp7M++pLGCo4wxKCYHdg7fy9kkkKSVLBPNeIX9HvHmOei2mi14G37nHBhJ4IjXfU2BG5sPb9i32Ex0bdbguoCrMvoZkCD9C8z16EyqoZJujg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772805120; c=relaxed/simple;
	bh=nyWdwpgttUjFe9Gx6eXPCJdCZS54q4ZmVUJNYwqHfm4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=VJMHGfnUyqH1Iapzz/lwn/69VzuBlj09g309LWN3XjmrhAthIq+BDBUXcWBMhz0ZD3RY0Yb4uYK597KiS4O7I6IkiS3231Tc2fggyBnOAlXsa6QOWNJy++v7ZMoLrMgyDfucIlM6Qn9JTsj9n40yDnxAwXwG6Hs8jTJSlSPxX2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=TtWDTa6N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LblhBxcA; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="TtWDTa6N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LblhBxcA"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 314491D00031;
	Fri,  6 Mar 2026 08:51:49 -0500 (EST)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-02.internal (MEProxy); Fri, 06 Mar 2026 08:51:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1772805108;
	 x=1772891508; bh=KqL28PEa1gdOtcPjGDXJw5E9578ySQPb6ffvqQWlJsw=; b=
	TtWDTa6N5XdzgvKQFRhorHPTlhV7A0q9pfvjkhQqY5fdr27du0GljCVHIslFQ3V8
	76jLfCfN1kePsMixnpVK91d/MiXGm9c74xF/2jkVWzAVuugTi5U1Z4ccY9HCI6Aw
	aDoWfig19yKARf+nqAGbrIP7ubgq0dhfZXqGHrEbbdbJHk1f4iplppvTrhFmUMSp
	Noh2Y/EeL/SAm1Fe5eb4mpJIn+B1mw5yh3jKLg2Cf8jmptE5i6rCNvB1d55diKbP
	h5Op5s0g2r9E/oaXaI+jyYUQZwb0RmB6LFb1Ay1ULn8B8r8xhWyXMFcZ5pDcah1T
	5I53FncpVlxO/RdAr6tiHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772805108; x=
	1772891508; bh=KqL28PEa1gdOtcPjGDXJw5E9578ySQPb6ffvqQWlJsw=; b=L
	blhBxcAshBjlo/AFGF1FaC49vbTEoasREDFsv033Yz63+tACjXJR8o28Ku5Umcrs
	ScVRCN0ETH8eaAmnPEsGxWDJDfn0ei00bo4npe2Zy1Loea3tyiWKfiNh1sBWVyKX
	J7IGf6J+2UXaxScTu/9e/N9ghx2YEaahlrPLJdozmuJqXPAwuTH2+Aty8Uzp/BK+
	3B8lRTM+C54pVymwN3mTHKqK0+/wp1LOQJrUBF0dwxLOpuG6uxbZIbY2AiboH0l0
	VuiwIKW940p79+2ZbNsceKNI7P1RCLJy2Qay84xom7NIHimIuJxoCKXpfIbNPQ4T
	9s7rDRyEDWqKFwZH4y8lA==
X-ME-Sender: <xms:9NuqaVa97MnFvIw0VPM7l8MSpT-LAOX5fujbs9_v92NLfutsAtZJTw>
    <xme:9NuqaXO1vqZbBf3BhnfcCgX0jv25XbCzuACZhvtVmuB49Cxcz4R4qaXwnruiv3gWm
    GS5uFWjAWF7sZ2kbstZMlcNPnLhE4sYs_4tTNpQZMYwyzIw3C39yUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieelgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfofgrrhhk
    ucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtg
    grqeenucggtffrrghtthgvrhhnpefhveekjeeuueekfefhleeljeehuedugfetffdvteek
    ffejudelffdvjeekfeehvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrpdhn
    sggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggvrh
    gvkhhjohhhnhdrtghlrghrkhesghhmrghilhdrtghomhdprhgtphhtthhopegumhhithhr
    hidrthhorhhokhhhohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvhhishhhnhhuoh
    gtvhesghhmrghilhdrtghomhdprhgtphhtthhopehhmhhhsehhmhhhrdgvnhhgrdgsrhdp
    rhgtphhtthhopehhrghnshhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehvshgrnh
    hkrghrsehlvghnohhvohdrtghomhdprhgtphhtthhopehilhhpohdrjhgrrhhvihhnvghn
    sehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepihgsmhdqrggtphhiqdguvg
    hvvghlsehlihhsthhsrdhsohhurhgtvghfohhrghgvrdhnvghtpdhrtghpthhtoheptgho
    rhgsvghtsehlfihnrdhnvght
X-ME-Proxy: <xmx:9NuqaWrSg8AF5PROqsg5PnniT3zw8stMKk9h9ko_dxGZ-HlRyYnX5A>
    <xmx:9NuqafDnGNTnFzH1MeA3TSavB_FhggH-qHeTmcBeneDnW7frsS5HTA>
    <xmx:9NuqaRUBA003l2u1uDcXkQMBx5kHE4PpjTdg7MgckKvaJWg03RWX5A>
    <xmx:9NuqaRB4A84c0Id_cVe7DUfEvJfaFgH2uE2Q4HvB73dX9XkfAZ0sjg>
    <xmx:9NuqaaFxQmgVNhwslrv0vDqk3fKYErBbQn1eL1ef6aCzJxd4JJk8itiK>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1D6CB2CE0072; Fri,  6 Mar 2026 08:51:48 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AA58JqlF_hbo
Date: Fri, 06 Mar 2026 08:51:25 -0500
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Vishnu Sankar" <vishnuocv@gmail.com>,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 "Henrique de Moraes Holschuh" <hmh@hmh.eng.br>,
 "Hans de Goede" <hansg@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 ibm-acpi-devel@lists.sourceforge.net, linux-doc@vger.kernel.org,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 "Vishnu Sankar" <vsankar@lenovo.com>
Message-Id: <8a352a34-5ddb-4aa8-b9e1-8c5c8aafca04@app.fastmail.com>
In-Reply-To: 
 <CABxCQKvNO78SeVp9pAnBOSAF=x0eFn03F33ftW-x-rZCG0-84Q@mail.gmail.com>
References: <20260209063355.491189-1-vishnuocv@gmail.com>
 <CABxCQKvNO78SeVp9pAnBOSAF=x0eFn03F33ftW-x-rZCG0-84Q@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] TrackPoint doubletap enablement and user control
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On Mon, Feb 23, 2026, at 6:28 PM, Vishnu Sankar wrote:
> Hi,
>
> Gentle ping on this series.
>
> This is v7 addressing all previous review comments.
> Please let me know if any further changes are needed.
>
> Thanks,
> Vishnu
>
>
> On Mon, Feb 9, 2026 at 3:34=E2=80=AFPM Vishnu Sankar <vishnuocv@gmail.=
com> wrote:
>>
>> This patch series adds support for TrackPoint doubletap with a clear =
and
>> simple separation of responsibilities between drivers:
>>
>> 1. Firmware enablement (trackpoint.c):
>>    Automatically enables doubletap on capable hardware during device
>>    detection.
>>
>> 2. User control (thinkpad_acpi.c):
>>    Provides a sysfs interface to enable or disable delivery of double=
tap
>>    events to userspace.
>>
>> The approach follows the KISS principle:
>> - The TrackPoint driver enables hardware functionality by default.
>> - The thinkpad_acpi driver controls whether ACPI doubletap events are
>>   delivered, using existing hotkey filtering infrastructure.
>> - No cross-driver APIs or dual filtering paths are introduced.
>>
>> Changes in v7:
>> - Removed unwanted comments and logs
>>
>> Changes in v6:
>> - Documentation: fix formatting of the doubletap_enable sysfs attribu=
te
>>   description (separate "Values" list)
>>
>> Changes in v5:
>> - Rename sysfs attribute from doubletap_filter to doubletap_enable to
>>   reflect actual behavior.
>> - Fix inverted logic so events are delivered only when doubletap is
>>   enabled.
>> - Suppress ACPI hotkey delivery instead of injecting or filtering inp=
ut
>>   events.
>> - Register the sysfs attribute via hotkey_attributes[] instead of
>>   device_create_file().
>> - Drop unnecessary helper wrappers and debug logging.
>> - Update Documentation to reflect the new naming and semantics.
>>
>> Changes in v4:
>> - Complete redesign based on reviewer feedback.
>> - trackpoint.c: Simplified to only enable doubletap by default.
>> - trackpoint.c: Removed all sysfs attributes and global variables.
>> - trackpoint.c: Uses firmware ID detection with deny list.
>> - thinkpad_acpi.c: Added sysfs interface for kernel-level event contr=
ol.
>> - thinkpad_acpi.c: No cross-driver dependencies.
>> - Documentation: Updated to reflect simplified sysfs approach.
>>
>> Changes in v3:
>> - No changes.
>>
>> Changes in v2:
>> - Improved commit messages.
>> - Removed unnecessary comments and debug messages.
>> - Switched to strstarts() usage.
>> - Simplified firmware capability detection logic.
>>
>> This version addresses the remaining review feedback by correcting the
>> naming and logic inversion, aligning sysfs semantics with behavior, a=
nd
>> fully integrating with existing thinkpad_acpi hotkey handling.
>>
>> Vishnu Sankar (3):
>>   input: trackpoint - Enable doubletap by default on capable devices
>>   platform/x86: thinkpad_acpi: Add sysfs control for TrackPoint
>>     double-tap
>>   Documentation: thinkpad-acpi - Document doubletap_enable attribute
>>
>>  .../admin-guide/laptops/thinkpad-acpi.rst     | 21 +++++++++
>>  drivers/input/mouse/trackpoint.c              | 45 +++++++++++++++++=
++
>>  drivers/input/mouse/trackpoint.h              |  5 +++
>>  drivers/platform/x86/lenovo/thinkpad_acpi.c   | 42 ++++++++++++++---
>>  4 files changed, 106 insertions(+), 7 deletions(-)
>>
>> --
>> 2.51.0
>>
>
>
> --
>
> Regards,
>
>       Vishnu Sankar

Hi Ilpo,

I was just discussing this with Vishnu and wanted to check if anything e=
lse was needed from your perspective for this patch?

I assume at this point we're waiting for the 7.1 merge window to open. P=
lease do let us know if there's anything you need from us in the meantim=
e.=20
We can't get this pulled into the distro's until it's accepted upstream =
- and while it's not a critical feature, we'd love it to be in place for=
 the Linux preloads for the 2026 platforms (coming up soon)

Thanks
Mark
