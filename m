Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B575F35201B;
	Fri, 16 Oct 2026 15:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792164663; cv=none; b=c2SWXXgrcBKW4fWb0e9iU82As0jRb8DjFbQf3mrZ4fBhwPDoE3+uhzt/CVu5xdF5r1EODBKoujreLXHtuzJRw69BVa8t4oly+RnzlmEFRm+annnDBVE+fUMBFnHCVl6XiryKtIqnWY6R9hYVkup/7efUfezJcWKuUlLjX8qwnGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792164663; c=relaxed/simple;
	bh=wk37APZy+LAxMu4TcTwvnXNCGISXLL+I/i8M6WlVG8I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iSWF9FvMVb+QybInosfE4tUt4b6koLUIIHU+VEugqwDaV1IMZ/cguNpDmQyz5hN9ztjlCM2teIQiTB3uCyVd0WkspsFqKteq7PRvMK+fsXUPaXdHrBmghNofIU94FiGsJz1mctRRbKBeD7fnK6h+/OsfhAbsdNGz0zVsg0pcGEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bsqxTGb3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bsqxTGb3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC6B71F000C4;
	Fri, 16 Oct 2026 15:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792164662;
	bh=NoSEgydSqdlOKEBkCItc9VqMPnxVvFSugHgF3wNZuwU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=bsqxTGb3d1FCXhS1kfS+NpXZkilOpYpPYxrquZa+vIjYymBMRjQej941DpB0FPaFb
	 DpkxCghxvubOwjf8xGZ7cnQi7gq7S+wIrXNd1p0y2b1NM1zqaR3kFmS7bHUrkin/8g
	 FWMPBgkd9/MtmtKtzN0Xs+bJ3+3e+hwnNuxcsAAbUbSoOLORn/8b219C3+ufai340q
	 faFAlaSQKCVE+PQKiqAgD6rEB3GOWeX4Z63OjJjF52dnEfwnElGMXdsdzwSUTDWFuq
	 UuTOx2a4QJgvz3+MBS3lIHQSg+KBo4QdRDlL/xdmm3Zoj6LGiKnAZrudQyB9blJtzT
	 XWjltQWuG6czQ==
From: Benjamin Tissoires <bentiss@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Bill Wendling <morbo@google.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Puranjay Mohan <puranjay@kernel.org>, Johan Hovold <johan@kernel.org>, 
 Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Kees Cook <kees@kernel.org>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20260923214246.3098156-1-morbo@google.com>
References: <20260923214246.3098156-1-morbo@google.com>
Subject: Re: [PATCH] HID: bpf: fix lockless race on device_data allocation
Message-Id: <179216463009.1243348.14434994323400434129.b4-ty@b4>
Date: Fri, 16 Oct 2026 17:30:30 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792164659; l=481;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=wk37APZy+LAxMu4TcTwvnXNCGISXLL+I/i8M6WlVG8I=;
 b=tMM5gv+pfDST95LDTIlvCejlWUAvjVgAS9CDeCI3O6xP7D+wsJ6yV/CsflKIjEvcKECi6crxk
 a+akcwWjuWMDyYhLn2TndRQzNkpXIPO0/k3RH2rvH7ZQCEbh44XhBP5
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

On Wed, 23 Sep 2026 21:42:46 +0000, Bill Wendling wrote:
> HID: bpf: fix lockless race on device_data allocation


That is a lot of effort for some very rare cases, but anyway, that seems
to do the trick:

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git (for-7.4/bpf), thanks!

[1/1] HID: bpf: fix lockless race on device_data allocation
      https://git.kernel.org/hid/hid/c/ff492a050bf4

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>

