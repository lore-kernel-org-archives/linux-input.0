From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/3] input: remove BKL from mousedev
Date: Tue, 9 Mar 2010 21:05:54 +0100
Message-ID: <201003092105.55102.arnd@arndb.de>
References: <1268162386-2745-1-git-send-email-cascardo@holoscopio.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1268162386-2745-1-git-send-email-cascardo@holoscopio.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, John Kacur <jkacur@gmail.com>
List-Id: linux-input@vger.kernel.org

On Tuesday 09 March 2010, Thadeu Lima de Souza Cascardo wrote:
> There's no need for BKL in mousedev. It uses lots of locking already
> that should handle the open case.
> 
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

I actually have the same ones in
http://git.kernel.org/?p=linux/kernel/git/arnd/playground.git;a=shortlog;h=refs/heads/bkl-removal
(yes, that's broken), so I'd really like to see them go in.

	Arnd
