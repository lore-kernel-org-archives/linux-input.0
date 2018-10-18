From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Input: uinput - fix Spectre v1 vulnerability
Date: Thu, 18 Oct 2018 20:43:44 +0100
Message-ID: <20181018204344.4c135203@alans-desktop>
References: <20181016111313.GA28307@embeddedor.com>
        <20181016172107.GA230131@dtor-ws>
        <ead3e95a-1acb-362a-0ee2-d02dbc4f378c@embeddedor.com>
        <26EEA6BC-43B0-42F7-A237-572D32EB2309@gmail.com>
        <2856297d-9af0-e005-f926-e9596d437fad@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2856297d-9af0-e005-f926-e9596d437fad@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, 16 Oct 2018 20:12:43 +0200
"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> On 10/16/18 8:09 PM, Dmitry Torokhov wrote:
> 
> > 
> > /dev/uinput   
> 
> I've got it. This explains it all. :)
> 
> > must be 0600, or accessible to equally privileged user, or you'll be opening your system to much mischief.

Still a correct change.

CAP_SYS_RAWIO is not the same as being root, especially in a container.

Alan
