From: Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: [PATCH] Input: mousedev - add a schedule point in
 mousedev_write()
Date: Thu, 4 Oct 2018 16:01:19 -0700
Message-ID: <2664c117-76c0-a60b-d76a-350ae7b6351a@gmail.com>
References: <20181004154749.111595-1-edumazet@google.com>
 <20181004185949.GA233675@dtor-ws> <20181004193407.GK2674@linux.ibm.com>
 <20181004225455.GC233675@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181004225455.GC233675@dtor-ws>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: Eric Dumazet <edumazet@google.com>, linux-kernel <linux-kernel@vger.kernel.org>, Eric Dumazet <eric.dumazet@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org



On 10/04/2018 03:54 PM, Dmitry Torokhov wrote:

> OK, I see. I'll apply the patch then.

Thanks !

> 
> I think evdev.c needs similar treatment as it will keep looping while
> there is data...

Yeah, presumably other drivers need care as well :/
