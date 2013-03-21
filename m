From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: Tree for Mar 21 (input)
Date: Thu, 21 Mar 2013 07:57:51 -0700
Message-ID: <514B1FEF.2090109@infradead.org>
References: <20130321173832.c72cc034bd67452c9c2c567b@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130321173832.c72cc034bd67452c9c2c567b@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 03/20/13 23:38, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20130320:
> 


on i386:

ERROR: "matrix_keypad_parse_of_params" [drivers/input/keyboard/tca8418_keypad.ko] undefined!



"matrix_keypad_parse_of_params" needs to be exported in
drivers/input/matrix-keymap.c.


-- 
~Randy
