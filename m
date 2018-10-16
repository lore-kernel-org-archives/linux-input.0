From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] Input: uinput - fix Spectre v1 vulnerability
Date: Tue, 16 Oct 2018 20:12:43 +0200
Message-ID: <2856297d-9af0-e005-f926-e9596d437fad@embeddedor.com>
References: <20181016111313.GA28307@embeddedor.com>
 <20181016172107.GA230131@dtor-ws>
 <ead3e95a-1acb-362a-0ee2-d02dbc4f378c@embeddedor.com>
 <26EEA6BC-43B0-42F7-A237-572D32EB2309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <26EEA6BC-43B0-42F7-A237-572D32EB2309@gmail.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org



On 10/16/18 8:09 PM, Dmitry Torokhov wrote:

> 
> /dev/uinput 

I've got it. This explains it all. :)

> must be 0600, or accessible to equally privileged user, or you'll be opening your system to much mischief.
> 
Thanks, Dmitry.
--
Gustavo
