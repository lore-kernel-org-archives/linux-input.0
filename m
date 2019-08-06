From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] Input: docs: fix spelling mistake "potocol" ->
 "protocol"
Date: Tue, 6 Aug 2019 11:24:28 -0600
Message-ID: <20190806112428.3ab5d604@lwn.net>
References: <20190805104951.26947-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190805104951.26947-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Henrik Rydberg <rydberg@bitmath.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon,  5 Aug 2019 11:49:51 +0100
Colin King <colin.king@canonical.com> wrote:

> There is a minor spelling mistake in the documentation, fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  Documentation/input/multi-touch-protocol.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/input/multi-touch-protocol.rst b/Documentation/input/multi-touch-protocol.rst
> index 6be70342e709..307fe22d9668 100644
> --- a/Documentation/input/multi-touch-protocol.rst
> +++ b/Documentation/input/multi-touch-protocol.rst
> @@ -23,7 +23,7 @@ devices capable of tracking identifiable contacts (type B), the protocol
>  describes how to send updates for individual contacts via event slots.
>  
>  .. note::
> -   MT potocol type A is obsolete, all kernel drivers have been
> +   MT protocol type A is obsolete, all kernel drivers have been
>     converted to use type B.

Applied, thanks.

jon
