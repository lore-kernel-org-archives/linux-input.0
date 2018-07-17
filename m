From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] Patch enabling Fn function keys for Laptop Asus G730
 (keyboard 0x1869)
Date: Tue, 17 Jul 2018 15:51:09 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1807171549510.997@cbobk.fhfr.pm>
References: <alpine.LNX.2.21.1806141112440.11126@Hermes.vereecke.mooo.com> <nycvar.YFH.7.76.1806251519190.6203@cbobk.fhfr.pm> <dc860e3a-c837-5571-95f4-e62065f1a7f4@vereecke.mooo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <dc860e3a-c837-5571-95f4-e62065f1a7f4@vereecke.mooo.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jan <vereecke.jan@skynet.be>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, benjamin.tissoires@redhat.com
List-Id: linux-input@vger.kernel.org

On Thu, 5 Jul 2018, jan wrote:

> Thanks for your reply. However, I am confused. Pleas bear with me as this is
> the very first time that I submit a patch and I followed some guidance that I
> found on the internet (obviously not the correct one).
> 
> I suppose I just need to delete the parts of the email where you write "this
> doesn't go in the changelog".

Yeah, please put into the patch changelog only the things that should end 
up in the actual commit log (the thing you see when doing git log / git 
show etc).

> I am not sure what my signoff should contain. Could you point me to a correct
> guide for this ?

Please read

	Documentation/process/submitting-patches.rst

signoffs specifically are discussed in paragraph 11.

Thanks!

-- 
Jiri Kosina
SUSE Labs
