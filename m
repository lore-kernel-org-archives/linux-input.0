Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A23305668;
	Tue, 23 Jun 2026 19:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782241339; cv=none; b=uZnIx5roKttXhoS8VEKyL6fza729oLUARqv2H4NOTmtiudgqV0m8ggfjXLeXycaDNJ1mwMzvHjcgWLu6GiggYhq2+IgAKy4yTby3Svt78dGzbP1CyMj3wt4Wsd4ru5dEaVBOCrqOKpuBcZsqjE/A9KXvBQ4qeRqWtyNusJ8LJPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782241339; c=relaxed/simple;
	bh=GU7NWTXIDfUJMHJycCyvVwQ1ojy/3x3xvuDc3TgWplY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uURDALVgTETntyU05CO+QcqVLjtBLgF/SfWetj2EHrpTa2i7ZtrZB+BE9LVb8uEUdi9o0XgFuoR5devoh9OlHNaB9Dox/w0uc8UPDTdKmHiB4yiBcn88rSFbtFwjLLvciqgr9nkAdcVuayn/+JcgrusNnKAzChRnxpQL1ay11mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OBjBgmgN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OBjBgmgN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D602B1F000E9;
	Tue, 23 Jun 2026 19:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782241337;
	bh=MkaY2VwyPwJbYfn95t9tJu2ROZOtSdP2Y3AB+zNvLxg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OBjBgmgNTFPaev8N8oou2giubQAYUxbfqppOfqTqqB0CpqcT1FHInD1uc/+BxhhtJ
	 wSogYEbgFsNuVy+iFjzZDdA4CxyZXhHxYn9AHZnoEerw4iDi+Ke4Fk9aoRBDGhN9S/
	 Q8HeNEoIIxhlxoZ21wuBNCqZzbBUgHWBQRoRWl+hLvb3QXjNMDn7UwEPGzT/Kh14+z
	 uCLAtUCFASqfVyA5kq8hUl6RrInbDoB4xhij/AoqGfCmoG5J/26gGvqbDman0qim6q
	 chHe6Ls/+xEKBhyT9mkSCe5RxnRq3tWufse613o2dhdT4pwAosGKar+nQ23c9yQqz9
	 B1pOIB/z0/qHw==
Date: Tue, 23 Jun 2026 20:02:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Sanjay Chitroda <sanjayembeddedse@gmail.com>, Jiri Kosina
 <jikos@kernel.org>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-input@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] HID: iio: callback API signature match for usage_id
Message-ID: <20260623200209.3ce87a94@jic23-huawei>
In-Reply-To: <ajLC09uEIOClVzEq@ashevche-desk.local>
References: <20260616-16-jun-hid-iio-u32-api-type-v1-0-952c74195f46@gmail.com>
	<ajLC09uEIOClVzEq@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Jun 2026 18:52:51 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Jun 16, 2026 at 06:55:19PM +0530, Sanjay Chitroda wrote:
> > 
> > Most of HID IIO driver has correct 'u32' type of usage_id with
> > https://lore.kernel.org/all/20260610-6-june-hid-iio-correct-usage-id-v2-0-c3c5f0720493@gmail.com/
> > series which is applied on iio/testing branch.
> > 
> > On top of the same, this series updates remaining HID IIO drivers
> > to use 'u32' for the usage_id parameter.
> > 
> > Pending list of HID IIO drivers are extracted with command line:
> > find drivers/iio/ -type f -name "*hid*" | xargs grep -A 5 static | \
> >     grep -E -A 5 "_proc_event\(|_capture_sample\(|_parse_report\(" --color | \
> >     grep usage_id  
> 
> I recommend to get used with `git grep ...` which is more powerful and much
> faster (on a Git index).
> 
> 	git grep -lw 'u[^3].* usage_id' -- drivers/iio/
> 
> for the list of files, and
> 
> 	git grep -np -w 'u[^3].* usage_id' -- drivers/iio/
> 
> for a better view.
> 
> (It gives one false positive, though :-)
> 
> > This matches expected callback API type as HID usage IDs are
> > defined as 32-bit values.
> > 
> > No functional changes are introduced.
> > 
> > Testing:
> >   - Compiled with W=1 for each patch in the series  
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
> Jonathan, it seems the missing part of the initial unification. Please, apply
> to your testing branch.
Applied to the testing branch of iio.git.

Thanks,

Jonathan

> 

