Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDD518A92F;
	Tue,  4 Aug 2026 10:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785839597; cv=none; b=Lssq1/WO4iLYcMokp5i5ttrUvr32bXndXIMUZR8TMc4yuVKnd8ScdpWCdBnLsOHFuwte25RJ5LVNrCXJ9JusVDIsnQRtZ9dil5BykgS88Qpg2Mzbo44/S6dVJOYq6uhgYeDUoT+d1j5uKWw1hejHBxfHkxFdaOPYWUmhgOhEqk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785839597; c=relaxed/simple;
	bh=Yy5qGcY3aQLg7L7w6TL1RpSH1A2YEFRYjYaYPh7hREU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B5oNa3VENpO2DMpX3Lk1OyvP1wkFS5q5niggHdqRDqhXb+zIYqCmi6odejfbt1f4Dse46VKfoRdOgEW8CEuggeOLsxiW5lGy/VoaXbXBeIKkSENGjjLa/S/VgpKlQgBXpZmj5ao/mS5fCo3CCR/0TFkEIUDRNnYNBt+++Qwro7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LikXfnYt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LikXfnYt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D719B1F000E9;
	Tue,  4 Aug 2026 10:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785839596;
	bh=jFwtwhZcFBen0+y+XKdHabgCmm6NRjMxF+Qq+0gBYYY=;
	h=Date:From:To:Subject:References:In-Reply-To;
	b=LikXfnYt5zYQAtxbPcAfn+1nJ2JvXfIFGUXU0BoWNJW/DIXvISRwosYNMONyAKfch
	 F1iKyRwPSKkNOeoqFGTc0SYtgZHJl4QyLWKyDtIlrjtbLzbqmzQeMVGg7Pc36RdB7+
	 ECYrzH/NMyWvtlL7atk4SnBNT293VM84iACgPjz6LlO+9/1IA1KCrvlPmDnpvcyu7U
	 LEuIt0akBgxJJgRI5xRLQb3wEqjVvQVeAPhDHZNTKZbCv8Gik/YEpO4dcMQnC+m+14
	 MyaKdn2e727AqPMNwlqwF4T6+wCOpurGhxDuJ2S1iYD+TYBssrwz7pjRBOTfLOodUZ
	 VG6Guyh7jcPbA==
Date: Tue, 4 Aug 2026 11:33:10 +0100
From: Lee Jones <lee@kernel.org>
To: Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Aaron Skomra <aaron.skomra@wacom.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Peter Hutterer <peter.hutterer@who-t.net>,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] HID: wacom: Advertise SW_MUTE_DEVICE capability
 prior to registration
Message-ID: <20260804103310.GA10716@google.com>
References: <20260804103030.1491356-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804103030.1491356-1-lee@kernel.org>

Ignore this submission please, I have forsaken the tools by omitting the version.

-- 
Lee Jones
