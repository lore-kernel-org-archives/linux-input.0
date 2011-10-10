From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH V3] input: Fix USB autosuspend on bcm5974
Date: Mon, 10 Oct 2011 22:16:41 +0100
Message-ID: <20111010211641.GA26460@srcf.ucam.org>
References: <1318261630-24044-1-git-send-email-mjg@redhat.com>
 <20111010210534.GA2223@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:34927 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751820Ab1JJVQn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Oct 2011 17:16:43 -0400
Content-Disposition: inline
In-Reply-To: <20111010210534.GA2223@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: linux-input@vger.kernel.org, dtor@mail.ru

Hmm. lsof agrees that I have no input devices open, but I see the 
bcm5974 device being suspended and then staying that way.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
