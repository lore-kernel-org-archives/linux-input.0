Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A5E391856;
	Wed,  8 Apr 2026 20:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775680910; cv=none; b=tNZ2pBiUZy5R9VazC9VI2AWoTm2yL3KJR0pIcEtmdUorxp6uRDApNeupi0Ui2nA54WNvV7lNCQqTmb7+LLWjeTRF7wkGZg9Zh7J9CxAECW8ANIaBFIERT4u4+QoSI6Y/uewrHxT/Ci9d6f03vSBRYN9L90hCMVlsBFWwZBRpdws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775680910; c=relaxed/simple;
	bh=osW7yoi5E+b3VYwIq3wq0nhrpRrPd4kBis4mxg7fmEw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=u8Za0QmUORyrevrR1V0cnTNv1/J46XfgFzIUIJvICU2n/Va+w6ebObPDXJTUTfmE28nFwWxKrTAojToFMLpEuDhR6fq7pFROR+m0cKod0HwN/jCpoEknTDvEmg5vfnQKX65aUi/OwHu409bJTX1t7p9nj5ote+FNoXGhldXgWdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BeJWCkqh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BeJWCkqh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F3E4C19425;
	Wed,  8 Apr 2026 20:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775680910;
	bh=osW7yoi5E+b3VYwIq3wq0nhrpRrPd4kBis4mxg7fmEw=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=BeJWCkqheCNaNA5G7VQMnmwiVDP/G59tDqZBZOMI9HOR6o/03p3xWWhVnhF6JDl6j
	 aA71Nrh5/hmVhR7neBdx6Og0ffMZgaha1HQ9wpnOT+6r0KN3Nchmkkjbcbq+06gdQF
	 Lqpm5mVs7OwIpggWZ2IxAAiF/+KpBI45adBNupy1rHkixB5kIYhSlWjLevbvoXlcWk
	 a7M1ONtA7auS8APQPWrgtd10Ee3mdgCS7mRFKbx66VFWM5WTFQkrMtmqMzcEdzK/3M
	 5lEBeYIBXmp3R1Hk87SSXvqohu9eiBHezpTzhEcniskbPWpG9cNxgeeeKKSJoOmfBf
	 S6PBtiplGyBiw==
Date: Wed, 8 Apr 2026 22:41:47 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Rosalie Wanders <rosalie@mailbox.org>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    Sanjay Govind <sanjay.govind9@gmail.com>, 
    Brenton Simpson <appsforartists@google.com>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] HID: sony: add support for more instruments
In-Reply-To: <20260407194636.9671-2-rosalie@mailbox.org>
Message-ID: <37nrpop7-rn05-pqo6-3951-171nr8nq441o@xreary.bet>
References: <20260407194636.9671-2-rosalie@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 7 Apr 2026, Rosalie Wanders wrote:

> This patch adds support for the following instruments:
> 
> * Rock Band 1/2/3 Wii/PS3 instruments
> * Rock Band 3 PS3 Pro instruments
> * DJ Hero Turntable
> 
> Wii and PS3 instruments are the same besides the vendor and product ID.
> 
> This patch also fixes the mappings for the existing Guitar Hero
> instruments.
> 
> Co-developed-by: Sanjay Govind <sanjay.govind9@gmail.com>
> Signed-off-by: Sanjay Govind <sanjay.govind9@gmail.com>
> Co-developed-by: Brenton Simpson <appsforartists@google.com>
> Signed-off-by: Brenton Simpson <appsforartists@google.com>
> Signed-off-by: Rosalie Wanders <rosalie@mailbox.org>
> ---
> changes:
> v2: correct squier device name and remove non-existent squier usb device

Rosalie,

as v1 is already sitting in hid.git#for-7.1/sony for some time, could you 
please send this as a followup fix instead? 

Thanks,

-- 
Jiri Kosina
SUSE Labs

