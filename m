Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA9EC433FE
	for <linux-input@archiver.kernel.org>; Fri, 22 Apr 2022 04:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443934AbiDVEXO (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 22 Apr 2022 00:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355549AbiDVEXN (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 22 Apr 2022 00:23:13 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191534992B;
        Thu, 21 Apr 2022 21:20:20 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4F58068B05; Fri, 22 Apr 2022 06:20:17 +0200 (CEST)
Date:   Fri, 22 Apr 2022 06:20:17 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, hch@lst.de, hannes@cmpxchg.org,
        akpm@linux-foundation.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-input@vger.kernel.org,
        roman.gushchin@linux.dev, rostedt@goodmis.org
Subject: Re: [PATCH v2 1/8] lib/printbuf: New data structure for
 heap-allocated strings
Message-ID: <20220422042017.GA9946@lst.de>
References: <20220421234837.3629927-1-kent.overstreet@gmail.com> <20220421234837.3629927-7-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220421234837.3629927-7-kent.overstreet@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

I still see absolutel no reason to bloat the kernel with a duplicate
of the existing seq_buf functionality.  Please use that and improve it
where needed for your use case.
