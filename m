From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH] Input: evdev - Fix incorrect kfree of err_free_client
 after vzalloc
Date: Wed, 11 Jun 2014 23:49:02 -0700 (PDT)
Message-ID: <alpine.DEB.2.02.1406112348430.23724@chino.kir.corp.google.com>
References: <1402537537-17945-1-git-send-email-ytk.lee@samsung.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1402537537-17945-1-git-send-email-ytk.lee@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yongtaek Lee <ytk.lee@samsung.com>
Cc: rydberg@euromail.se, dmitry.torokhov@gmail.com, daniels@collabora.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 12 Jun 2014, Yongtaek Lee wrote:

> This bug was introduced by commit 92eb77d ("Input: evdev - fall back
> to vmalloc for client event buffer").
> 
> vzalloc is used to alloc memory as fallback in case of failure
> of kzalloc. But err_free_client was not considered on below case.
> 1. kzalloc fail
> 2. vzalloc success
> 3. evdev_open_device fail
> 4. kfree
> 
> So that address checking is needed to call correct free function.
> 
> Signed-off-by: Yongtaek Lee <ytk.lee@samsung.com>
> Reviewed-by: Daniel Stone <daniels@collabora.com>

Acked-by: David Rientjes <rientjes@google.com>
