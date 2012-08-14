From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: linux-next: Tree for Aug 14 (drivers/input/touchscreen/edt-ft5x06.c)
Date: Tue, 14 Aug 2012 10:59:28 -0700
Message-ID: <502A9200.1020606@xenotime.net>
References: <20120814135506.b6b86e3c8cb9da1eefb7bbd6@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120814135506.b6b86e3c8cb9da1eefb7bbd6@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Simon Budig <simon.budig@kernelconcepts.de>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 08/13/2012 08:55 PM, Stephen Rothwell wrote:

> Hi all,
> 
> Changes since 20120813:
> 


on x86_64, when CONFIG_DEBUG_FS is not enabled:

drivers/input/touchscreen/edt-ft5x06.c: In function 'edt_ft5x06_ts_remove':
drivers/input/touchscreen/edt-ft5x06.c:846:14: error: 'struct edt_ft5x06_ts_data' has no member named 'raw_buffer'


-- 
~Randy
