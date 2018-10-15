From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] Input: atmel_mxt_ts - mark expected switch fall-through
Date: Mon, 15 Oct 2018 20:30:46 +0200
Message-ID: <40e247eb-1654-461b-d189-37163e456acb@embeddedor.com>
References: <20181008170355.GA18107@embeddedor.com>
 <20181015182156.GD127224@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181015182156.GD127224@dtor-ws>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Nick Dyer <nick@shmanahar.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org



On 10/15/18 8:21 PM, Dmitry Torokhov wrote:
> On Mon, Oct 08, 2018 at 07:03:55PM +0200, Gustavo A. R. Silva wrote:
>> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
>> where we are expecting to fall through.
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> Applied, thank you.
> 

Thanks, Dmitry.
--
Gustavo
