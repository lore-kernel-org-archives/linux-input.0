Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C853BADA8
	for <linux-input@vger.kernel.org>; Wed, 18 Mar 2026 10:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773831542; cv=pass; b=Mt5HJnBB55rs5uFpU9wgNYSB/H0iNEee57jO5H4CElLWc/qKb7N2NdGr7HB+S/wbTIX8ja9B8tlJGRbprRCBnredwKxBJ/VSuJpZSBEnTJR9hISCLmY+QZed7tolPydzTLUGLAUb3NWUkfmO+CDPm/9CwAuenBhi+AXPAVLgJIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773831542; c=relaxed/simple;
	bh=LVVELEXkmiKTU/p+oy+of4jebFSUmNrxF9w9nex4moo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BdZ0gO+QHRYIH9GdMkC+tSWxZ/OZTaYnzgTHpWBosYgpGF4iDsjueqvsp03B7QD+g6BVJR1qaZa77eEz2Zy21FaimEz1gQNu2ZiOwL4wdc6o04HSqMkRmWt9E/Tj2mDxDN/IqUX2z4LAS5+FdcVW7rwmZSfqJ0hq/tbbcbwbO4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=Y+F4gIrC; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="Y+F4gIrC"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-79a3e2e64f4so21553867b3.1
        for <linux-input@vger.kernel.org>; Wed, 18 Mar 2026 03:58:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773831537; cv=none;
        d=google.com; s=arc-20240605;
        b=ik46RNW4QYkSSZWXBxXYbVWYCLdhxUtF2wSJj9f3JEvBLFRB86uU+pIKYqLH9tRpeA
         LQARkkPbHYMIFQrYmAnk3tCt+8zmkzvHZNYgBCuYlceoA+ldm3Nv7aDJrrve07zLszIU
         YGio5TIIKYQGiKnbYS8fchedNNaGwT28Mv94XUk2a5Awxl7ODSrrL7M8LNJRGikfTQPw
         2pVIvk0T+sYvQIjWvPdebl5+/i4EX9Q7M6aVifHDMW37TrhubgT6ws6Lp+3eLBuN/XY9
         JAX1ujJfmPMRGIIHr+lDgKRG0jIkPTGn1I46UgQiz5f2TufhQbdLK4g/Cs0LgVx3qXZw
         gFLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LVVELEXkmiKTU/p+oy+of4jebFSUmNrxF9w9nex4moo=;
        fh=GFPYWNQ9WaVXA6PJtTL9O6yUZcXhQ9TCDU6upMqDgI0=;
        b=A1ML6nawHK4KiGg1NnyakYUvq/4tTDfcaWwCY5Kz2P7hks/mL/Zzr9h1KPe5MfC2jh
         iufSOaqLkRS8a+/TJLvQs+CJ4/BHx0wse+R2fNoXoLQQBwhL/xKcGHIZ2+bnjExUODmR
         3RhKgDKLp5KBlqCLXxXL57/pW5ClIAJKwyzu/6Dyhv41LpDa/mxkpDDEIYu+weHUbgzV
         SCmOCNAFNfbF3xYXi8MBzedw084lThu1e2yFRNQdOyPgJ77TaJXTJJSF84dP88rYcA8E
         cgi0U34db6uRUDOQ1oDyvge2n+9mt7FtV/b7vq+by+6IFbrGzlhZqbBGDbojTOVOFPpz
         InCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1773831537; x=1774436337; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LVVELEXkmiKTU/p+oy+of4jebFSUmNrxF9w9nex4moo=;
        b=Y+F4gIrCy3AlMDM7CSYzAY8MdpN5nfDAenVYSS8jF8/QGMe0BtbaqtvpoNu4HHsdwI
         eCHGz033wV+iu7o9yHNzl8ab1W8iVYNVNBYMUrCHRQLI9DZgf1n+KJ5WGJM874ZC8E1f
         V8AfDwxwo6eY0vCZpRljMsNdbb7jgkZbz3BUBCDiRZdtki+wXyJ231XN2e5CQzBOtHl2
         RNzehobgF8tA59rhsLrK604RjKLDzwzujNWXDWsClMTvJ5qFhXeMw/pwvPnR1XkeD7qu
         tmTv/A7/XayQthiGv4k2dz99RPffdzi9GNohb9QPIB0xHVtAoLzYczErYFx/GTFFdjmi
         QFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773831537; x=1774436337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LVVELEXkmiKTU/p+oy+of4jebFSUmNrxF9w9nex4moo=;
        b=l4JFV1LVf+Tl+PGfztFC2cfX2FDrU1UmyTwdhqHY5g0mAzSioCWj3vNDl1o7L7H3ub
         DOwpwevRe4mAqwx5pQ1khtQ4MaOzaRsgvjm1u5wX6u7OHkX4kZq0BCjPdot2yXfFz2Pi
         cPCrhWMMFmE16QfXUI5tx0ojLLr9J/TVbh/aqwC6OzTGeZ/WKMNger9SlMmQD6NePIKt
         vfcP3hmgAIoqeW2gufLjAnwN8L6KI0ejDfQhlopLWKI2ujJO0T3bqR9DEQg/sxbirjzW
         pXK1gAo+l5qnk+vFtCEIHmo1yOU3ezzVyjifPxvYA3HVjbSzEm69KaNy7vHrKFP//In8
         t+9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXZXUrfJ7CKwWHpYRZ67KzKYEBCSftZq462Ue5z0ivNWjaqGA0QqOxvSCflatTpX4LEfVSMq9SPlzn+Jw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVlk9QJUc4J1CP6HSbhFoniMOYEGA+l3S5WZEz2+TYhUzN5K1S
	AiL4dZaS9YnJ9p0/95YOyvWZMRRKlYOR++k2chlH1Nr8NoxcohOB7YdPVoqkuHn76brTw9F0U9y
	iwJBoT/f7BUwaLuZuZJI0PngacKcCQubaXZ5cCRjmUQ==
X-Gm-Gg: ATEYQzy7tnt6H9qre0QD9U3F1Xle9bIEhCo6j6m3ss4QYIW87DtUmaAsu9bMbno48ys
	CSNbYNNiC1QPQwy+4eE9Aw15c/czhNb+ckvQGzQTs0jyKaPhUC6ts69sxSlEe2ruUWAfZzkcY0n
	WnmlANcqnDyi1OO4grRDpfMlzFONsmZzEPIrfdM3ToXg3ipFF2WEh/3yh2sMhddbCgtbdxApfQa
	uEzcyyMCXy0PHZpJ+0mODntM4TYP8xu5YPtv/vKXBcLEW2lYbvXpy8NBlgDw9BNetmk6vguGoKL
	fygkylY=
X-Received: by 2002:a05:690c:c50e:b0:79a:3a33:933 with SMTP id
 00721157ae682-79a71ad413dmr29714557b3.31.1773831537485; Wed, 18 Mar 2026
 03:58:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
 <1e3c2830-765e-4271-89f7-0b6784b37597@efficios.com> <20260312112354.3dd99e36@gandalf.local.home>
 <219d015d-076b-4c80-8f63-88569115fdad@efficios.com> <20260312114041.5193c729@gandalf.local.home>
 <1becdbce-2c01-468a-bbab-42b5dea9fdf8@efficios.com> <CAO7JXPjnnruhM5oC6xMgnYaQ9efzYFqMCFiJLNM3HCQ+ZeCiJw@mail.gmail.com>
 <CAEf4BzbnfyhCqp0ne=2gRnVxp-mdGmuZwDeFRyhRYH+eDcz2-w@mail.gmail.com>
 <20260312130255.6476e560@gandalf.local.home> <CAO7JXPgHYZ9zF1HFahb2447X85YRZCQQBHB6ihOwKSDtiZi8kQ@mail.gmail.com>
 <20260317120049.6a60fa88@gandalf.local.home> <6ca9f884-9566-4a82-9995-4c802a0bf8a0@efficios.com>
In-Reply-To: <6ca9f884-9566-4a82-9995-4c802a0bf8a0@efficios.com>
From: Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date: Wed, 18 Mar 2026 06:58:46 -0400
X-Gm-Features: AaiRm52iP799baA3h48fwfLjW02Pe87nEMlmDoXLIPKYRV2LFYQQkuww_KlSUU0
Message-ID: <CAO7JXPgbERfc_P+aPFB1+nR5ua3mZGbhdkbxCr0TFR4Cr6Khuw@mail.gmail.com>
Subject: Re: [PATCH 00/15] tracepoint: Avoid double static_branch evaluation
 at guarded call sites
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Dmitry Ilvokhin <d@ilvokhin.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	io-uring@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Jon Maloy <jmaloy@redhat.com>, Aaron Conole <aconole@redhat.com>, 
	Eelco Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-sctp@vger.kernel.org, 
	tipc-discussion@lists.sourceforge.net, dev@openvswitch.org, 
	Oded Gabbay <ogabbay@kernel.org>, Koby Elbaz <koby.elbaz@intel.com>, 
	dri-devel@lists.freedesktop.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	Huang Rui <ray.huang@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Len Brown <lenb@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	linux-pm@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, linaro-mm-sig@lists.linaro.org, 
	Eddie James <eajames@linux.ibm.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Joel Stanley <joel@jms.id.au>, linux-fsi@lists.ozlabs.org, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alex Deucher <alexander.deucher@amd.com>, Danilo Krummrich <dakr@kernel.org>, 
	Matthew Brost <matthew.brost@intel.com>, Philipp Stanner <phasta@kernel.org>, 
	Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
	amd-gfx@lists.freedesktop.org, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, linux-spi@vger.kernel.org, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org, 
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 12:02=E2=80=AFPM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> On 2026-03-17 12:00, Steven Rostedt wrote:
> > On Fri, 13 Mar 2026 10:02:32 -0400
> > Vineeth Remanan Pillai <vineeth@bitbyteword.org> wrote:
> >
> >>>
> >>> Perhaps: call_trace_foo() ?
> >>>
> >> call_trace_foo has one collision with the tracepoint
> >> sched_update_nr_running and a function
> >> call_trace_sched_update_nr_running. I had considered this and later
> >> moved to trace_invoke_foo() because of the collision. But I can rename
> >> call_trace_sched_update_nr_running to something else if call_trace_foo
> >> is the general consensus.
> >
> > OK, then lets go with: trace_call__foo()
> >
> > The double underscore should prevent any name collisions.
> >
> > Does anyone have an objections?
> I'm OK with it.
>
Great thanks! I shall send a v2 with s/trace_invoke_foo/trace_call__foo/ so=
on.

Thanks,
Vineeth
