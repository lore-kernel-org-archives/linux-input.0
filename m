Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A57C3E1697;
	Fri, 15 May 2026 18:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778870623; cv=none; b=ROQf2SdDQCDhPEZIeLtp/5h5uqSn/alSpR+lrMtGI5ftomkZJcI2UEJzbjfTCYu5fB0wCClf2NTo1EuV2Lfap2FgE4afFRTfq1vjLF8JN+pFOghU4ug0CXah94QrueLQCn23PDlIJINWpzea4HgQekIjKplXiJ5sI0f/SRsfCcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778870623; c=relaxed/simple;
	bh=/i/l7AXeQUov0UTjM92xVOvCFYJJXBr6Y2LEwirkdIs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UoQiDiXBfNWvh/RsWpUjKVElTqF8M+IN38uxsZNdY5mE1AwAvQ+YqPj3RH0mmkvX0Euaeg2bsq9zfrv1WYqgQyZNBdV5D5SkkwvIxbf7JizOmHZUb6zV0m/EhDuLghPic+vQMAE2cFVAQK2NegeXn2yor4PbnDCDkyW0dV8a4zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 9DD80401A0;
	Fri, 15 May 2026 18:43:36 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id A9CA53D;
	Fri, 15 May 2026 18:43:34 +0000 (UTC)
Date: Fri, 15 May 2026 14:43:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>, Jiri Kosina 
 <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 linux-input@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Peter
 Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 07/11] HID: Use trace_call__##name() at guarded
 tracepoint call sites
Message-ID: <20260515144342.4831ffbf@gandalf.local.home>
In-Reply-To: <fbc8c9659f707f46b5d8a6479fc42d5bb1d0efcd.camel@linux.intel.com>
References: <20260515135941.2238861-1-vineeth@bitbyteword.org>
	<fbc8c9659f707f46b5d8a6479fc42d5bb1d0efcd.camel@linux.intel.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A9CA53D
X-Stat-Signature: jgkz5q55po7665daiuniqw68ypbsr7ws
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19oaxuoqROKa4ZGa3Aum94fKrsBrAldK5o=
X-HE-Tag: 1778870614-221438
X-HE-Meta: U2FsdGVkX197hdDiWcgU6rmDar4AY7Im6VViIa10AB1W4Gd+1pgQvaO+5fPL3MzMzH73UiyKpCDBC6jTnYSRUmfPj6zJZwovG8L6Vokntl7TBdPdtatgiHFvagyuGSYlXk0AOxSY/YTwWaPo5HtYy2ZzC16K84jSOJg8QNJQ6Yx7LLPutUE3pksd2J8RxMVIe2ZBWDjYNsl/VB8DkK7ATkahIowuumjfvd2adshJrkFuiL4XaRVARu6ijFQMEb7JH+7LBxxI9+2dOn89a7Y3ifohEWkfYCPXY3qynVypdydoSj1PNKdljAn+TnuFoL0AVy63pvSnApkT7AJ/C6SWBbJI1s/ajzOF2tA/m0oXjj2VQj7yitySCRlem19pqKq6+n7cYqqyGHKW8RcjmGdgxuTvoIzKjQWTdli8frrnrloWVmvVt8hJNFrQQ4suFlicM3xpwEAbPAhXzeFqZ6HwgGLWYhUgA+kxr3d+ea6hKS0uqNIj6dGVP9dReX1W1IdJQvcbP+f1Ksr3/8CZrg8SS32rQ5HHlUEX2a17yTYgGwM=

On Fri, 15 May 2026 08:09:25 -0700
srinivas pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> On Fri, 2026-05-15 at 09:59 -0400, Vineeth Pillai (Google) wrote:
> > From: Vineeth Pillai <vineeth@bitbyteword.org>
> > 
> > Replace trace_foo() with the new trace_call__foo() at sites already
> > guarded by trace_foo_enabled(), avoiding a redundant
> > static_branch_unlikely() re-evaluation inside the tracepoint.
> > trace_call__foo() calls the tracepoint callbacks directly without
> > utilizing the static branch again.
> > 
> > Original v2 series:
> > https://lore.kernel.org/linux-trace-kernel/20260323160052.17528-1-vineeth@bitbyteword.org/
> > 
> > Parts of the original v2 series have already been merged in mainline.
> > This patch is being reposted as a follow-up cleanup for the remaining
> > unmerged pieces.
> > 
> > Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
> > Assisted-by: Claude:claude-sonnet-4-6  
> 
>     Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> 

Thanks, I'll take this through my tree.

-- Steve
