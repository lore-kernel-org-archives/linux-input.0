Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521B62F7EE0;
	Thu,  1 Oct 2026 23:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790897354; cv=none; b=KeHE9TVj1QBJ9Sqmd5P2vuxAgRC9yPbEcwUopJeZlFvhMuwZViCYQiFdkr3gjzz0n8lqrYAtn+akNCUu5aeIEJ3qonctMw8eDOLzplCq5D1AnHwVnYR3q0Kb/vBiMpqDbAJ3NMFfvTqKidOKznOEFEwBntJHaHRuW7a/YDtoIAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790897354; c=relaxed/simple;
	bh=F9sNR8uDTG36T1yCX+2t3qyQu6bPwVnlyLuwhWIk1YM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=uDGpMsRmFHRY3mCK1fHpVdUZhsvjcDV2i+uQF8A1GK28nK7nc8Wo2i26HToCvFq3XnxMpmWdsbaPKx5AICHZnjSNiiJ17hffrs+XA1X06RwBN3zHHSVL0Ey/qbRQSWyC5cf3Syq5Lrk1oVlKEFSS7eS1hDltGR0O9Ihjg3MoHFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=fail (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CpeBFHqH reason="signature verification failed"; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CpeBFHqH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFE651F000FF;
	Thu,  1 Oct 2026 23:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790897353;
	bh=UCp1D+bv7tlX4Dr/jntNO+4AHuP9rt2modE0wkIcwtc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=CpeBFHqHmryldip33VnRdbzF7UDAkLGKgPdQ9lHYGrW6rtOepKTkX10IheVlSV68s
	 zP0+ZgJcG6bJNHQ09dSoiIdm4t4Q2z8WoOAAtjBk0k7/hl4Md2ZyvgW3poockTNLH2
	 NaSj4VRTTucIRopc40Fe4twHCke9Vh2jXEzblEZ2qOYNojWt8POe7HzKlwHhLj7wD2
	 NerpPQWJ3T/qkqRnZP6EaMXe+ywenBpGPOz4vFuzDM5605Fuz9abCJM58rGHBQDe4C
	 ml6DhqhVjbS1yy2XEBmIPvgjYCC6tdMC0fEwobsoCpL99DTeXhZka9b3v7UpLTruYk
	 3SBAUkOKC/JnA==
Content-Type: multipart/mixed; boundary="===============6923769064512196432=="
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <562cbc38006e96e7fed9d935db2dbf4849bb20353f3fc86be22980680557d9d3@mail.kernel.org>
In-Reply-To: <20261001225214.12351-11-wanjay@amazon.com>
References: <20261001225214.12351-11-wanjay@amazon.com>
Subject: Re: [PATCH bpf-next v4 10/12] resolve_btfids: add --btf_link to fill in .BTF.link records
From: bot+bpf-ci@kernel.org
To: wanjay@amazon.com,bpf@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: alan.maguire@oracle.com,martin.lau@linux.dev,yonghong.song@linux.dev,jolsa@kernel.org,ihor.solodrai@linux.dev,qmo@kernel.org,nathan@kernel.org,nsc@kernel.org,linux-kbuild@vger.kernel.org,linux@weissschuh.net,christian@heusel.eu,mcgrof@kernel.org,petr.pavlu@suse.com,samitolvanen@google.com,linux-modules@vger.kernel.org,rostedt@goodmis.org,mhiramat@kernel.org,mathieu.desnoyers@efficios.com,linux-trace-kernel@vger.kernel.org,acme@kernel.org,namhyung@kernel.org,irogers@google.com,linux-perf-users@vger.kernel.org,jikos@kernel.org,bentiss@kernel.org,linux-input@vger.kernel.org,tj@kernel.org,void@manifault.com,arighi@nvidia.com,changwoo@igalia.com,sched-ext@lists.linux.dev,shuah@kernel.org,linux-kselftest@vger.kernel.org,ojeda@kernel.org,rust-for-linux@vger.kernel.org,arnd@arndb.de,linux-doc@vger.kernel.org,linux-kernel@vger.kernel.org,abuehaze@amazon.com,doebel@amazon.de,mpohlack@amazon.de,jay.wang.upstream@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kern
 el.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu,  1 Oct 2026 23:29:10 +0000 (UTC)

--===============6923769064512196432==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> resolve_btfids: add --btf_link to fill in .BTF.link records

TL;DR: Not a bug: patch_btf_link() duplicates most of patch_btfids()'s ELF
open/find-section/update code, so each --btf_link reopens and rewrites the
file; suggests a shared helper or a single ELF handle.

> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c

[ ... ]

> +static int patch_btf_link(const char *elf_path, const struct btf_link *link)
> +{

[ ... ]

> +	elf_version(EV_CURRENT);
> +	fd = open(elf_path, O_RDWR);
> +	if (fd < 0) {
> +		pr_err("FAILED to open %s: %s\n", elf_path, strerror(errno));
> +		goto out_data;
> +	}
> +	elf = elf_begin(fd, ELF_C_RDWR_MMAP, NULL);
> +	if (!elf) {
> +		pr_err("FAILED cannot create ELF descriptor: %s\n", elf_errmsg(-1));
> +		goto out_close;
> +	}
> +	elf_flagelf(elf, ELF_C_SET, ELF_F_LAYOUT);

[ ... ]

> +	if (elf_getshdrstrndx(elf, &shdrstrndx)) {
> +		pr_err("FAILED cannot get shdr str ndx\n");
> +		goto out_elf;
> +	}
> +	while ((scn = elf_nextscn(elf, scn))) {
> +		if (gelf_getshdr(scn, &sh) != &sh) {
> +			pr_err("FAILED to get section header\n");
> +			goto out_elf;
> +		}
> +		name = elf_strptr(elf, shdrstrndx, sh.sh_name);
> +		if (name && !strcmp(name, section))
> +			break;
> +	}

[ ... ]

> +	elf_flagdata(data, ELF_C_SET, ELF_F_DIRTY);
> +	if (elf_update(elf, ELF_C_WRITE) < 0) {
> +		pr_err("FAILED to update ELF file %s: %s\n", elf_path, elf_errmsg(-1));
> +		goto out_elf;
> +	}

[ ... ]

> @@ -1773,21 +1974,28 @@ int main(int argc, const char **argv)
[ ... ]
> -	if (btfids_path)
> -		return patch_btfids(btfids_path, obj.path);
> +	if (btfids_path) {
> +		err = patch_btfids(btfids_path, obj.path);
> +		for (i = 0; !err && i < btf_links.cnt; i++)
> +			err = patch_btf_link(obj.path, &btf_links.links[i]);
> +		goto out;
> +	}

This isn't a bug, but patch_btf_link() repeats most of what patch_btfids()
does just above it: elf_version(), open(O_RDWR), elf_begin(ELF_C_RDWR_MMAP),
elf_flagelf(ELF_F_LAYOUT), the elf_getshdrstrndx() plus elf_nextscn() /
gelf_getshdr() / elf_strptr() / strcmp() loop that finds a section by name,
and the elf_flagdata(ELF_F_DIRTY) / elf_update() / elf_end() / close()
teardown.  Only the section name and what gets written into data->d_buf
differ.

With the loop in main(), a --patch_btfids run with N --btf_link options
opens, maps and rewrites the same ELF file N + 1 times.

Could the two share a small helper that opens the ELF and returns the
Elf_Data of a named section, or could the .BTF.link records be written while
.BTF_ids is being patched, using the same ELF handle?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36938681172
--===============6923769064512196432==--
